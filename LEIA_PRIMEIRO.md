# Complemento de códigos recuperados

Este pacote **complementa** o repositório `tech-challenge-alfabetizacao` que já foi publicado. Foi montado a partir de códigos SQL extraídos do histórico real de jobs do BigQuery.

## Publicação no GitHub

1. Extraia o ZIP no computador.
2. Abra o repositório do GitHub na raiz e escolha **Add file > Upload files**.
3. Envie as pastas `sql`, `docs` e `evidencias` extraídas (não o arquivo ZIP). Os caminhos foram preparados para serem acrescentados aos que já existem.
4. Confira que os arquivos novos aparecem dentro das subpastas correspondentes antes de confirmar o commit.
5. Use a mensagem de commit: **Adiciona SQLs recuperados do histórico do BigQuery**.

**Não substitua o `README.md` atual nem os arquivos SQL Gold 01 a 07:** este pacote foi feito para acrescentar arquivos, sem sobrescrever os existentes. Se você já colocou o link do vídeo no README, ele permanecerá intacto.

## Cuidados

- Os arquivos SQL preservam o corpo dos comandos originais encontrados, com comentários acrescentados no início para registrar o Job ID e as limitações.
- **Não execute tudo de uma vez.** Algumas instruções usam `CREATE OR REPLACE` e apagariam versões atuais; outras são exemplos antigos e testes criados para falhar.
- Em `sql/qualidade/teste_controlado`, o segundo SQL deve produzir erro intencionalmente. É evidência do mecanismo de bloqueio, não um comando da execução normal.
- Consulte `docs/codigos_recuperados.md` para entender o que foi encontrado e o que ainda não foi recuperado.
