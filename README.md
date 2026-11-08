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
  <a href="https://github.com/marcelocorni/happytreenode-releases/releases/download/v0.1.0-alpha.23.2/HappyTreeNode-Setup-0.1.0-alpha.23.2-win-x64.exe"><strong>Baixar para Windows x64</strong></a>
  · <a href="https://happytreenode.com.br">Portal</a>
  · <a href="https://github.com/marcelocorni/happytreenode-releases/releases">Todas as versões</a>
</p>

Repositório de distribuição dos instaladores oficiais do **HappyTreeNode**. O código-fonte do aplicativo não é incluído aqui. O uso depende de cadastro e de uma avaliação ou licença válida.

Suporte: suporte@happytreenode.com.br
## Download

Os instaladores são disponibilizados na seção **Releases** deste repositório. Baixe o arquivo `.exe` da versão desejada e execute-o. O Setup oferece atalhos para Cliente, Servidor Local e desinstalação.

A versão [0.1.0-alpha.23.2](https://github.com/marcelocorni/happytreenode-releases/releases/tag/v0.1.0-alpha.23.2) inclui notificações e chatbot por Telegram e Discord, gestão de contas de bots e manual detalhado com instalação, IDs, permissões e diagnóstico. São 233 nós, 89 cenários e 127 workflows de exemplo em 23 plugins. Os exemplos 87 a 89 incluem notificações, simulações locais e variantes para gatilhos. É cumulativa e preserva os recursos anteriores.

A versão [0.1.0-alpha.22.3](https://github.com/marcelocorni/happytreenode-releases/releases/tag/v0.1.0-alpha.22.3) inclui APIs Google (Drive, Planilhas, Docs, Apresentações, Forms e Classroom), cores de fundo/texto dos nós e post-its, anotações recolhíveis, recuperação de horários, ordenação em disco e Markdown para HTML/PDF. São 229 nós, 86 cenários e 121 workflows de exemplo. O workspace padrão passa para happytreenode, **sem migração automática da pasta anterior**; consulte as instruções da release.

A versão [0.1.0-alpha.20](https://github.com/marcelocorni/happytreenode-releases/releases/tag/v0.1.0-alpha.20) inclui comandos em grupos do WhatsApp Web, síntese de voz local com Kokoro e respostas com play direto na conversa. São 200 nós, 76 cenários e 104 workflows de exemplo.

A versão [0.1.0-alpha.19](https://github.com/marcelocorni/happytreenode-releases/releases/tag/v0.1.0-alpha.19) inclui post-its no canvas, título, cor e nota por nó, consulta por campo e verificação de existência nas tabelas do projeto. São 197 nós, 74 cenários e 100 workflows de exemplo.

A versão [0.1.0-alpha.18](https://github.com/marcelocorni/happytreenode-releases/releases/tag/v0.1.0-alpha.18) inclui espera persistente, webhooks locais, tabelas de projeto e deduplicação entre execuções. São 196 nós, 73 cenários e 99 workflows de exemplo.

A versão [0.1.0-alpha.17](https://github.com/marcelocorni/happytreenode-releases/releases/tag/v0.1.0-alpha.17) inclui anexação de linhas, desdobramento de listas JSON, compactação e extração ZIP, leitura XML e RSS e busca por metadados. São 186 nós, 68 cenários e 94 workflows de exemplo.

A versão [0.1.0-alpha.16](https://github.com/marcelocorni/happytreenode-releases/releases/tag/v0.1.0-alpha.16) inclui comparação de tabelas, falhas com mensagem e workflows de erro. O manual traz a conciliação de pedidos entre CSV e SQLite. São 179 nós, 65 cenários e 91 workflows de exemplo.

A versão [0.1.0-alpha.15](https://github.com/marcelocorni/happytreenode-releases/releases/tag/v0.1.0-alpha.15) está disponível para Windows x64. Inclui correlações de Pearson e Spearman, avaliação de classificação e comparação de sinalizações em painéis interativos. São 177 nós, 64 cenários e 89 workflows de exemplo.

A versão [0.1.0-alpha.14](https://github.com/marcelocorni/happytreenode-releases/releases/tag/v0.1.0-alpha.14) está disponível para Windows x64. Inclui leitura e exportação Parquet, transformações em lote, Switch e novas repetições, com 174 nós, 62 cenários e 87 workflows de exemplo.

A versão [0.1.0-alpha.13.3](https://github.com/marcelocorni/happytreenode-releases/releases/tag/v0.1.0-alpha.13.3) está disponível para Windows x64, com fotos e legendas no WhatsApp, correção do salvamento de workflows importados e opção de TLS obrigatório para MySQL. É cumulativa e inclui os seletores de arquivos, APIs OAuth2, pesquisa IMAP, PDFs, calendários, regressão, previsão temporal e painéis exploráveis nos temas Claro e Escuro.

A [versão 0.1.0-alpha.7](https://github.com/marcelocorni/happytreenode-releases/releases/tag/v0.1.0-alpha.7) permanece disponível no GitHub, com certificados SSL, assinaturas de e-mail/PDF e confirmação humana persistente.

A [versão 0.1.0-alpha.8](https://github.com/marcelocorni/happytreenode-releases/releases/tag/v0.1.0-alpha.8) acrescenta cotas e fila de campanhas de e-mail, consulta incremental IMAP e gatilho de chegada de mensagens. É cumulativa e inclui os recursos da alpha.7.

As versões [alpha.11](https://github.com/marcelocorni/happytreenode-releases/releases/tag/v0.1.0-alpha.11) (PDFs, calendários e Comunicações) e [alpha.12](https://github.com/marcelocorni/happytreenode-releases/releases/tag/v0.1.0-alpha.12) (regressão e previsão temporal) também permanecem disponíveis com seus próprios instaladores e notas.

## Integridade

Cada versão acompanha um arquivo `.sha256` e um manifesto `release.json`. Confira o SHA-256 do instalador antes de executá-lo:

```powershell
Get-FileHash .\HappyTreeNode-Setup-0.1.0-alpha.23.2-win-x64.exe -Algorithm SHA256
```

Compare o resultado com o checksum publicado na mesma release e com o mostrado no Portal.

## Organização para manutenção

- `releases/`: manifestos das versões, sem dados privados ou caminhos locais.
- `release-notes/`: notas destinadas à publicação nas Releases.
- `dist/<versão>/`: arquivos preparados localmente para upload; pasta ignorada pelo Git.

**Não adicione os executáveis ao Git.** O instalador deve ser anexado como asset de uma GitHub Release. Os assets ficam em `dist/<versão>/`: o Setup, seu `.sha256`, `release.json` e, quando presentes, `CHANGELOG.md` e `INSTALACAO.md`.

O origin deste repositório é https://github.com/marcelocorni/happytreenode-releases.git. Para preparar os assets de uma versão em rascunho, use `scripts/Upload-Draft.ps1` com a autenticação existente do Git Credential Manager. O script confere os hashes e não publica a release.
