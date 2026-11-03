# Pequeno ajuste recomendado no README atual

O README publicado anteriormente dizia que os códigos de ingestão, streaming e monitoramento não estavam reunidos no repositório. Após a recuperação, esse trecho ficou parcialmente desatualizado. Em vez de substituir todo o README e correr o risco de apagar o link do vídeo, ajuste apenas o parágrafo sobre a situação da entrega. Sugestão:

> Foram recuperados códigos SQL originalmente executados no BigQuery para a carga inicial Bronze, tratamentos Silver, cinco indicadores antigos da Gold e etapas de qualidade, streaming e monitoramento. Os arquivos estão organizados em `sql/` e os Job IDs históricos constam em `docs/indice_jobs_recuperados.csv`. Com isso, a documentação do código ficou mais completa. Ainda falta o código original do produtor dos eventos de streaming e o processo completo não está automatizado para execução do zero. A carga Bronze recuperada também não preserva versões entre execuções, e algumas métricas são snapshots, como detalhado em `docs/codigos_recuperados.md`.

Não altere o link do vídeo, se já estiver inserido no README.
