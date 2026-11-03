#!/usr/bin/env python3
"""Executa scripts SQL Gold no BigQuery via CLI bq já autenticado.

Requisitos: Python 3 e Google Cloud SDK com bq disponível no PATH.
Uso: python scripts/run_gold.py --project SEU_PROJETO --location US
As tabelas Bronze e Silver devem existir previamente.
"""
import argparse
import re
import subprocess
from pathlib import Path


def main():
    parser = argparse.ArgumentParser(description='Publica sete tabelas Gold com SQL versionado.')
    parser.add_argument('--project', required=True, help='ID GCP do projeto com Bronze e Silver')
    parser.add_argument('--location', default='US', help='Localizacao dos datasets, ex. US')
    parser.add_argument('--only', type=int, choices=range(1, 8), help='Executa somente uma etapa (1 a 7)')
    args = parser.parse_args()
    if not re.fullmatch(r'[a-z][a-z0-9-]{4,61}[a-z0-9]', args.project):
        parser.error('ID de projeto invalido')
    root = Path(__file__).resolve().parent.parent
    sqls = sorted((root / 'sql' / 'gold').glob('*.sql'))
    if args.only:
        sqls = [q for q in sqls if q.name.startswith(f'{args.only:02d}_')]
    for path in sqls:
        sql = path.read_text(encoding='utf-8').replace('__PROJECT_ID__', args.project)
        print(f'Executando {path.name}... ', flush=True)
        subprocess.run(
            ['bq', 'query', '--use_legacy_sql=false',
             f'--project_id={args.project}', f'--location={args.location}',
             '--format=prettyjson'],
            input=sql, text=True, check=True)
        print(f'OK: {path.name}', flush=True)


if __name__ == '__main__':
    main()
