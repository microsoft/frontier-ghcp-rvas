#!/usr/bin/env bash

set -euo pipefail

CHALLENGE_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$CHALLENGE_ROOT"

if ! command -v docker >/dev/null 2>&1; then
  echo "Docker is unavailable. Running the portable validation fallback."
  exec bash scripts/validate.sh
fi

case "$(uname -m)" in
  arm64|aarch64)
    echo "ARM host detected. SQL Server will use linux/amd64 emulation."
    echo "If the runtime cannot start, use scripts/validate.sh and validate live on Azure SQL."
    ;;
esac

docker compose up -d sqlserver

sqlcmd_path="/opt/mssql-tools18/bin/sqlcmd"
for attempt in $(seq 1 60); do
  if docker compose exec -T sqlserver "$sqlcmd_path" \
    -S localhost -U sa -P "${MSSQL_SA_PASSWORD:-LocalOnly_Strong_Password_2026!}" \
    -C -Q "SELECT 1" >/dev/null 2>&1; then
    break
  fi
  if [[ "$attempt" -eq 60 ]]; then
    echo "SQL Server did not become ready. Run scripts/validate.sh for portable validation."
    exit 1
  fi
  sleep 2
done

run_sql() {
  local file="$1"
  docker compose exec -T sqlserver "$sqlcmd_path" \
    -S localhost -U sa -P "${MSSQL_SA_PASSWORD:-LocalOnly_Strong_Password_2026!}" \
    -C -b -d DatabaseRescue < "$file"
}

docker compose exec -T sqlserver "$sqlcmd_path" \
  -S localhost -U sa -P "${MSSQL_SA_PASSWORD:-LocalOnly_Strong_Password_2026!}" \
  -C -b -Q "IF DB_ID(N'DatabaseRescue') IS NULL CREATE DATABASE DatabaseRescue;"

run_sql sql/schema/001_transactional_schema.sql
run_sql sql/seed/010_deterministic_skew.sql
docker compose cp sql/workload/. sqlserver:/var/opt/mssql/workload/ >/dev/null
docker compose exec -T -w /var/opt/mssql/workload sqlserver "$sqlcmd_path" \
  -S localhost -U sa -P "${MSSQL_SA_PASSWORD:-LocalOnly_Strong_Password_2026!}" \
  -C -b -d DatabaseRescue -i 030_run_baseline.sql

echo "SQL Server 2022 schema, seed, and baseline workload completed."
echo "Run scripts/validate.sh after editing, then verify optional Azure SQL behavior separately."
