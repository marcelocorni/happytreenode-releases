# HappyTreeNode — versões oficiais

Repositório de distribuição dos instaladores oficiais do **HappyTreeNode**.

**Happy workflows, serious automation.**

- Portal: https://happytreenode.com.br
- Suporte: suporte@happytreenode.com.br
- Plataforma desta entrega: Windows x64.

O código-fonte do aplicativo não é incluído neste repositório. O uso do HappyTreeNode depende de cadastro e de uma avaliação ou licença válida.

## Download

Os instaladores são disponibilizados na seção **Releases** deste repositório. Baixe o arquivo `.exe` da versão desejada e execute-o. O Setup oferece atalhos para Cliente, Servidor Local e desinstalação.

A versão `0.1.0-alpha.1` está em validação. O instalador ainda não possui assinatura Authenticode de publicador.

## Integridade

Cada versão acompanha um arquivo `.sha256` e um manifesto `release.json`. Confira o SHA-256 do instalador antes de executá-lo:

```powershell
Get-FileHash .\HappyTreeNode-Setup-0.1.0-alpha.1-win-x64.exe -Algorithm SHA256
```

Compare o resultado com o checksum publicado na mesma release e com o mostrado no Portal. Um checksum confere integridade; não substitui assinatura digital do publicador.

## Organização para manutenção

- `releases/`: manifestos das versões, sem dados privados ou caminhos locais.
- `release-notes/`: notas destinadas à publicação nas Releases.
- `dist/<versão>/`: arquivos preparados localmente para upload; pasta ignorada pelo Git.

**Não adicione os executáveis ao Git.** O instalador deve ser anexado como asset de uma GitHub Release. Para a versão atual, os assets estão em `dist/0.1.0-alpha.1/`: o Setup, seu `.sha256` e `release.json`.

O origin deste repositório é https://github.com/marcelocorni/happytreenode-releases.git. Para preparar os assets de uma versão em rascunho, use `scripts/Upload-Draft.ps1` com a autenticação existente do Git Credential Manager. O script confere os hashes e não publica a release. A troca do endereço de download no Portal é uma etapa separada.
