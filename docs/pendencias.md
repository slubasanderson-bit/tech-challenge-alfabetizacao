# Para finalizar a entrega de hoje

Este arquivo é um controle de trabalho, não precisa ser apresentado como resultado técnico. A prioridade é mostrar evidências do que já rodou e fechar os entregáveis obrigatórios.

## Fazer antes de enviar

- [ ] Subir os arquivos extraídos para um repositório GitHub (não enviar só o ZIP).
- [ ] Colocar em `evidencias/` capturas do BigQuery mostrando as tabelas e ao menos um job de criação Gold com `SUCCESS`.
- [ ] Se disponíveis, anexar capturas e/ou o código dos testes de streaming (evento válido, duplicado e inválido) e qualidade com falha bloqueante.
- [ ] Anexar os scripts originais de ingestão Bronze, demais transformações Silver e monitoramento, se forem localizados. Se não forem, manter a limitação declarada.
- [ ] Concluir a estimativa mensal de custos em `docs/finops.md`, com tarifa, unidade e frequência de execução.
- [ ] Gravar e publicar vídeo de até cinco minutos. Inserir o link no README.
- [ ] Conferir acesso ao GitHub e ao vídeo em janela anônima.

## Conferência rápida antes do envio

- [ ] Nenhum token, senha, arquivo de serviço ou dado individual de aluno foi publicado.
- [ ] Arquivos SQL usam `__PROJECT_ID__` e o README explica o que substituir.
- [ ] O README não promete streaming ponta a ponta, alertas, atualização automática ou pipeline limpa do zero sem evidência.
- [ ] As tabelas de Silver e Monitoring têm expiração configurada em 01/01/2027; revisar se a apresentação futura depender delas.
- [ ] Se houver tempo, testar `scripts/run_gold.py` em ambiente com dados Silver preparados. Isso **não** equivale ao teste completo da ingestão.

## Limitações assumidas

A origem da cobertura geográfica incompleta em 2023 e 2024 não foi determinada; as sete tabelas Gold foram materializadas no BigQuery, mas alguns scripts das etapas anteriores não foram recuperados; métricas persistidas e alertas não foram verificados de ponta a ponta. Melhor registrar esses pontos do que supor que funcionam.
