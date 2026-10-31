param([Parameter(Mandatory)][ValidatePattern('^[0-9]+\.[0-9]+\.[0-9]+(?:-[A-Za-z0-9.-]+)?$')][string]$Version)
$ErrorActionPreference='Stop'
$root=[IO.Path]::GetFullPath((Split-Path $PSScriptRoot -Parent))
Set-Location -LiteralPath $root
$repository='marcelocorni/happytreenode-releases'
if((git remote get-url origin) -ne ('https://github.com/'+$repository+'.git')){throw 'Origin diferente do repositorio de distribuicao.'}
$manifest=Get-Content -LiteralPath (Join-Path $root ('releases/'+$Version+'.json')) -Raw|ConvertFrom-Json
$dist=Join-Path $root ('dist/'+$Version)
$state=Get-Content -LiteralPath (Join-Path $dist 'draft-state.json') -Raw|ConvertFrom-Json
if($manifest.version -ne $Version -or $state.tag -ne ('v'+$Version) -or [long]$state.id -le 0){throw 'Manifesto ou rascunho invalido.'}
$token=$null;$credentialLines=$null;$client=$null
try {
    $credentialLines="protocol=https`nhost=github.com`n`n"|git credential fill
    if($LASTEXITCODE -ne 0){throw 'Autenticacao GitHub indisponivel.'}
    foreach($line in $credentialLines){if($line.StartsWith('password=')){$token=$line.Substring(9)}}
    if([string]::IsNullOrWhiteSpace($token)){throw 'Autenticacao GitHub indisponivel.'}
    $client=[Net.Http.HttpClient]::new();$client.Timeout=[TimeSpan]::FromSeconds(60)
    $client.DefaultRequestHeaders.UserAgent.ParseAdd('HappyTreeNode-release')
    $client.DefaultRequestHeaders.Authorization=[Net.Http.Headers.AuthenticationHeaderValue]::new('Bearer',$token)
    $client.DefaultRequestHeaders.Accept.ParseAdd('application/vnd.github+json')
    $client.DefaultRequestHeaders.Add('X-GitHub-Api-Version','2022-11-28')
    function Api([string]$path,[string]$method='GET',[string]$body=''){
        $request=[Net.Http.HttpRequestMessage]::new([Net.Http.HttpMethod]::new($method),('https://api.github.com/repos/'+$repository+$path))
        try {
            if($body){$request.Content=[Net.Http.StringContent]::new($body,[Text.Encoding]::UTF8,'application/json')}
            $response=$client.SendAsync($request).GetAwaiter().GetResult()
            try {if(-not $response.IsSuccessStatusCode){throw ('GitHub HTTP '+[int]$response.StatusCode)};return ($response.Content.ReadAsStringAsync().GetAwaiter().GetResult()|ConvertFrom-Json)}
            finally {$response.Dispose()}
        } finally {$request.Dispose()}
    }
    function Assert-Assets($release){
        if($release.tag_name -ne ('v'+$Version) -or [long]$release.id -ne [long]$state.id){throw 'Release diferente da esperada.'}
        foreach($name in @($manifest.fileName,($manifest.fileName+'.sha256'),'release.json')){
            $file=Join-Path $dist $name;$asset=@($release.assets|Where-Object name -eq $name)
            if($asset.Count -ne 1){throw 'Asset remoto ausente ou duplicado.'}
            $hash=(Get-FileHash -LiteralPath $file -Algorithm SHA256).Hash.ToLowerInvariant();$size=(Get-Item -LiteralPath $file).Length
            if($asset[0].size -ne $size -or $asset[0].digest -ne ('sha256:'+$hash)){throw 'Hash ou tamanho remoto divergente.'}
            if($name -eq $manifest.fileName -and ($hash -ine $manifest.sha256 -or $size -ne $manifest.bytes)){throw 'Manifesto divergente do instalador.'}
        }
    }
    $release=Api ('/releases/'+$state.id);Assert-Assets $release
    $body=@{tag_name=('v'+$Version);target_commitish=(git rev-parse HEAD);name=('HappyTreeNode '+$Version);body=[IO.File]::ReadAllText((Join-Path $root ('release-notes/'+$Version+'.md')));draft=$false;prerelease=$true}|ConvertTo-Json
    $release=Api ('/releases/'+$state.id) 'PATCH' $body
    $release=Api ('/releases/tags/v'+$Version);Assert-Assets $release
    if($release.draft -or -not $release.published_at){throw 'A publicacao nao foi confirmada.'}
    @{id=$release.id;tag=$release.tag_name;draft=$release.draft;publishedAt=$release.published_at;url=$release.html_url;assets=@($release.assets|Select-Object name,size,digest,browser_download_url)}|ConvertTo-Json -Depth 5|Set-Content -LiteralPath (Join-Path $dist 'published-state.json') -Encoding UTF8
    Write-Host ('Release publicada e conferida: '+$release.html_url)
} finally {if($client){$client.Dispose()};$token=$null;$credentialLines=$null}
