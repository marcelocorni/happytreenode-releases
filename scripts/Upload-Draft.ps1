param([ValidatePattern('^[0-9]+\.[0-9]+\.[0-9]+(?:-[A-Za-z0-9.-]+)?$')][string]$Version='0.1.0-alpha.1')
$ErrorActionPreference='Stop'
$root=[IO.Path]::GetFullPath((Split-Path $PSScriptRoot -Parent))
Set-Location -LiteralPath $root
$repository='marcelocorni/happytreenode-releases'
$origin=git remote get-url origin
if($origin -ne ('https://github.com/'+$repository+'.git')){throw 'Origin diferente do repositorio de distribuicao.'}
$manifest=Get-Content -LiteralPath (Join-Path $root ('releases/'+$Version+'.json')) -Raw|ConvertFrom-Json
if($manifest.version -ne $Version -or $manifest.fileName -cnotmatch '^HappyTreeNode-Setup-[0-9A-Za-z.-]+-win-x64\.exe$'){throw 'Manifesto invalido.'}
$dist=Join-Path $root ('dist/'+$Version)
$files=@($manifest.fileName,($manifest.fileName+'.sha256'),'release.json')
foreach($name in $files){if(-not (Test-Path -LiteralPath (Join-Path $dist $name) -PathType Leaf)){throw 'Asset ausente.'}}
$exe=Join-Path $dist $manifest.fileName
if((Get-Item -LiteralPath $exe).Length -ne $manifest.bytes -or (Get-FileHash -LiteralPath $exe -Algorithm SHA256).Hash -ine $manifest.sha256){throw 'Checksum do instalador invalido.'}
$token=$null;$credentialLines=$null;$client=$null
try {
    # Existing Git Credential Manager authentication; no credential is printed or saved.
    $credentialLines="protocol=https`nhost=github.com`n`n"|git credential fill
    if($LASTEXITCODE -ne 0){throw 'Autenticacao GitHub indisponivel.'}
    foreach($line in $credentialLines){if($line.StartsWith('password=')){$token=$line.Substring(9)}}
    if([string]::IsNullOrWhiteSpace($token)){throw 'Autenticacao GitHub indisponivel.'}
    $client=[Net.Http.HttpClient]::new();$client.Timeout=[TimeSpan]::FromMinutes(20)
    $client.DefaultRequestHeaders.UserAgent.ParseAdd('HappyTreeNode-release')
    $client.DefaultRequestHeaders.Authorization=[Net.Http.Headers.AuthenticationHeaderValue]::new('Bearer',$token)
    $client.DefaultRequestHeaders.Accept.ParseAdd('application/vnd.github+json')
    $client.DefaultRequestHeaders.Add('X-GitHub-Api-Version','2022-11-28')
    function Api([string]$path,[string]$body='') {
        $request=[Net.Http.HttpRequestMessage]::new($(if($body){[Net.Http.HttpMethod]::Post}else{[Net.Http.HttpMethod]::Get}),('https://api.github.com/repos/'+$repository+$path))
        try {
            if($body){$request.Content=[Net.Http.StringContent]::new($body,[Text.Encoding]::UTF8,'application/json')}
            $response=$client.SendAsync($request).GetAwaiter().GetResult()
            try {if(-not $response.IsSuccessStatusCode){throw ('GitHub HTTP '+[int]$response.StatusCode)};return ($response.Content.ReadAsStringAsync().GetAwaiter().GetResult()|ConvertFrom-Json)}
            finally {$response.Dispose()}
        } finally {$request.Dispose()}
    }
    $tag='v'+$Version
    $release=@(Api '/releases?per_page=100'|Where-Object tag_name -eq $tag)|Select-Object -First 1
    if(-not $release){
        $body=@{tag_name=$tag;target_commitish=(git rev-parse HEAD);name=('HappyTreeNode '+$Version);body=[IO.File]::ReadAllText((Join-Path $root ('release-notes/'+$Version+'.md')));draft=$true;prerelease=$true}|ConvertTo-Json
        $release=Api '/releases' $body
    }
    if(-not $release.draft -or [long]$release.id -le 0){throw 'A versao nao e rascunho; nenhum asset sera alterado.'}
    Write-Host ('Rascunho preparado: '+$tag)
    foreach($name in $files){
        $file=Join-Path $dist $name;$hash=(Get-FileHash -LiteralPath $file -Algorithm SHA256).Hash.ToLowerInvariant()
        $size=(Get-Item -LiteralPath $file).Length
        $asset=@($release.assets|Where-Object name -eq $name)|Select-Object -First 1
        if(-not $asset){
            Write-Host ('Enviando '+$name+' ('+$size+' bytes)...')
            $url='https://uploads.github.com/repos/'+$repository+'/releases/'+$release.id+'/assets?name='+[Uri]::EscapeDataString($name)
            $request=[Net.Http.HttpRequestMessage]::new([Net.Http.HttpMethod]::Post,$url)
            $stream=[IO.File]::OpenRead($file)
            try {
                $request.Content=[Net.Http.StreamContent]::new($stream)
                $request.Content.Headers.ContentType=[Net.Http.Headers.MediaTypeHeaderValue]::new('application/octet-stream')
                $response=$client.SendAsync($request).GetAwaiter().GetResult()
                try {if(-not $response.IsSuccessStatusCode){throw ('Upload GitHub HTTP '+[int]$response.StatusCode)};$asset=$response.Content.ReadAsStringAsync().GetAwaiter().GetResult()|ConvertFrom-Json}
                finally {$response.Dispose()}
            } finally {$request.Dispose();$stream.Dispose()}
        }
        if($asset.size -ne $size -or $asset.digest -ne ('sha256:'+$hash)){throw 'Tamanho ou hash remoto diferente. Rascunho preservado para conferencia.'}
        Write-Host ('Conferido: '+$name)
    }
    $release=Api ('/releases/'+$release.id)
    @{id=$release.id;tag=$tag;draft=$release.draft;url=$release.html_url;assets=@($release.assets|Select-Object name,size,digest)}|ConvertTo-Json -Depth 5|Set-Content -LiteralPath (Join-Path $dist 'draft-state.json') -Encoding UTF8
    Write-Host 'Assets conferidos. Release mantida em RASCUNHO; download publico ainda nao liberado.'
} catch {Write-Host ('Operacao nao concluida: '+$_.Exception.Message);exit 1}
finally {if($client){$client.Dispose()};$token=$null;$credentialLines=$null}