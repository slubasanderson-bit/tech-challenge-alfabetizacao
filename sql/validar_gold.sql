-- Conferência rápida das comparações publicadas em 2024.
SELECT
    'ESTADUAL' AS abrangencia,
    COUNT(*) AS total_registros,
    COUNTIF(situacao_meta_2024 = 'ATINGIDA') AS metas_atingidas,
    COUNTIF(situacao_meta_2024 = 'NAO_ATINGIDA') AS metas_nao_atingidas,
    COUNTIF(situacao_meta_2024 IN ('SEM_RESULTADO', 'META_INDISPONIVEL')) AS indisponiveis
FROM `__PROJECT_ID__.gold.comparacao_metas_estaduais`
UNION ALL
SELECT
    'BRASIL',
    COUNT(*),
    COUNTIF(situacao_meta_2024 = 'ATINGIDA'),
    COUNTIF(situacao_meta_2024 = 'NAO_ATINGIDA'),
    COUNTIF(situacao_meta_2024 = 'INDISPONIVEL')
FROM `__PROJECT_ID__.gold.comparacao_metas_brasil`;
