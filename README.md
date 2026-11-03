<p align="center">
  <img src="assets/app-icon.png" width="72" alt="Logo HappyTreeNode">
</p>
<p align="center">
  <img src="assets/happytree-node.png" width="800" alt="Mascote HappyTreeNode — Happy workflows, serious automation.">
</p>

<h1 align="center">Versões oficiais do HappyTreeNode</h1>

<p align="center">
  Automatize tarefas, conecte dados e crie workflows visuais.
</p>
<p align="center">
  <a href="https://github.com/marcelocorni/happytreenode-releases/releases/download/v0.1.0-alpha.13/HappyTreeNode-Setup-0.1.0-alpha.13-win-x64.exe"><strong>Baixar para Windows x64</strong></a>
  · <a href="https://happytreenode.com.br">Portal</a>
  · <a href="https://github.com/marcelocorni/happytreenode-releases/releases">Todas as versões</a>
</p>

Repositório de distribuição dos instaladores oficiais do **HappyTreeNode**. O código-fonte do aplicativo não é incluído aqui. O uso depende de cadastro e de uma avaliação ou licença válida.

Suporte: suporte@happytreenode.com.br
## Download

Os instaladores são disponibilizados na seção **Releases** deste repositório. Baixe o arquivo `.exe` da versão desejada e execute-o. O Setup oferece atalhos para Cliente, Servidor Local e desinstalação.

A versão [0.1.0-alpha.13](https://github.com/marcelocorni/happytreenode-releases/releases/tag/v0.1.0-alpha.13) está disponível para Windows x64, com APIs OAuth2, repetições GET e pesquisa de e-mails por critérios e cursor. É cumulativa e inclui PDFs com senha, calendários, regressão, previsão temporal e painéis exploráveis nos temas Claro e Escuro.

A [versão 0.1.0-alpha.7](https://github.com/marcelocorni/happytreenode-releases/releases/tag/v0.1.0-alpha.7) permanece disponível no GitHub, com certificados SSL, assinaturas de e-mail/PDF e confirmação humana persistente.

A [versão 0.1.0-alpha.8](https://github.com/marcelocorni/happytreenode-releases/releases/tag/v0.1.0-alpha.8) acrescenta cotas e fila de campanhas de e-mail, consulta incremental IMAP e gatilho de chegada de mensagens. É cumulativa e inclui os recursos da alpha.7.

As versões [alpha.11](https://github.com/marcelocorni/happytreenode-releases/releases/tag/v0.1.0-alpha.11) (PDFs, calendários e Comunicações) e [alpha.12](https://github.com/marcelocorni/happytreenode-releases/releases/tag/v0.1.0-alpha.12) (regressão e previsão temporal) também permanecem disponíveis com seus próprios instaladores e notas.

## Integridade

Cada versão acompanha um arquivo `.sha256` e um manifesto `release.json`. Confira o SHA-256 do instalador antes de executá-lo:

```powershell
Get-FileHash .\HappyTreeNode-Setup-0.1.0-alpha.13-win-x64.exe -Algorithm SHA256
```

Compare o resultado com o checksum publicado na mesma release e com o mostrado no Portal.

## Organização para manutenção

- `releases/`: manifestos das versões, sem dados privados ou caminhos locais.
- `release-notes/`: notas destinadas à publicação nas Releases.
- `dist/<versão>/`: arquivos preparados localmente para upload; pasta ignorada pelo Git.

**Não adicione os executáveis ao Git.** O instalador deve ser anexado como asset de uma GitHub Release. Os assets ficam em `dist/<versão>/`: o Setup, seu `.sha256`, `release.json` e, quando presentes, `CHANGELOG.md` e `INSTALACAO.md`.

O origin deste repositório é https://github.com/marcelocorni/happytreenode-releases.git. Para preparar os assets de uma versão em rascunho, use `scripts/Upload-Draft.ps1` com a autenticação existente do Git Credential Manager. O script confere os hashes e não publica a release.
