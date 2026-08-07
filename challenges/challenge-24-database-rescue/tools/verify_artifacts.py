#!/usr/bin/env python3
"""Validate the database rescue starter and participant submission."""

from __future__ import annotations

import argparse
import csv
import json
import re
import sys
import xml.etree.ElementTree as ET
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
QUERY_IDS = {"Q1", "Q2", "Q3", "Q4"}
PLACEHOLDERS = ("replace this section", "add the ", "todo", "tbd")


class VerificationError(Exception):
    """Raised when an artifact contract is broken."""


def read(relative_path: str) -> str:
    path = ROOT / relative_path
    if not path.is_file():
        raise VerificationError(f"missing required file: {relative_path}")
    return path.read_text(encoding="utf-8")


def require(condition: bool, message: str) -> None:
    if not condition:
        raise VerificationError(message)


def query_ids(text: str) -> set[str]:
    return set(re.findall(r"Query ID:\s*(Q[1-4])\b", text, re.IGNORECASE))


def verify_starter() -> list[str]:
    checks: list[str] = []
    schema = read("sql/schema/001_transactional_schema.sql")
    seed = read("sql/seed/010_deterministic_skew.sql")
    workload = read("sql/workload/020_slow_queries.sql")
    baseline = read("sql/workload/030_run_baseline.sql")
    diagnostics = read("sql/workload/040_capture_diagnostics.sql")
    contract = json.loads(read("contracts/migration-contract.json"))
    compose = read("compose.yaml")

    expected_tables = {
        "Sales.Customer",
        "Catalog.Product",
        "Sales.SalesOrder",
        "Sales.SalesOrderLine",
        "Sales.PaymentAttempt",
    }
    actual_tables = set(
        re.findall(r"CREATE\s+TABLE\s+([A-Za-z]+\.[A-Za-z]+)", schema, re.IGNORECASE)
    )
    require(actual_tables == expected_tables, "schema table set does not match the fixture contract")
    require("Email nvarchar(320) NOT NULL" in schema, "current Email contract is missing")
    require("EmailAddress" not in schema, "starter schema must precede the migration")
    checks.append("transactional schema")

    for expected_count in ("10000", "200", "100000", "300000"):
        require(expected_count in seed, f"seed script is missing expected count {expected_count}")
    require("(10000 * e.digit)" in seed, "seed script must derive deterministic row numbers")
    require("NEWID()" not in seed.upper(), "seed script must not use random GUID ordering")
    require("THROW 51000" in seed, "seed script must fail when fixture counts drift")
    checks.append("deterministic skewed seed")

    require(query_ids(workload) == QUERY_IDS, "slow workload must define Q1 through Q4 exactly")
    require("SET STATISTICS IO ON" in baseline, "baseline must capture logical reads")
    require("SET STATISTICS TIME ON" in baseline, "baseline must capture CPU and elapsed time")
    require("020_slow_queries.sql" in baseline, "baseline must run the authoritative workload")
    require("sys.dm_exec_query_stats" in diagnostics, "diagnostics must inspect query statistics")
    require("sys.dm_exec_requests" in diagnostics, "diagnostics must inspect active requests")
    checks.append("workload and baseline scripts")

    require(contract["target"] == "Sales.Customer", "migration target does not match the schema")
    require(contract["current_column"]["name"] == "Email", "migration current column is inconsistent")
    require(contract["new_column"]["name"] == "EmailAddress", "migration target column is inconsistent")
    require(contract["compatibility_window"]["minimum_minutes"] >= 60, "compatibility window is too short")
    checks.append("migration contract")

    with (ROOT / "evidence/baseline-query-stats.csv").open(
        encoding="utf-8", newline=""
    ) as handle:
        rows = list(csv.DictReader(handle))
    require({row["query_id"] for row in rows} == QUERY_IDS, "baseline CSV query IDs drifted")
    require(all(int(row["avg_logical_reads"]) > 0 for row in rows), "baseline reads must be positive")

    waits = json.loads(read("evidence/wait-stats.json"))
    require(waits["capture_window_seconds"] == 300, "wait fixture window must remain repeatable")
    require(len(waits["waits"]) >= 4, "wait fixture is too small for diagnosis")

    with (ROOT / "evidence/blocking-snapshot.csv").open(
        encoding="utf-8", newline=""
    ) as handle:
        blocking_rows = list(csv.DictReader(handle))
    require(len(blocking_rows) >= 3, "blocking fixture needs multiple observations")
    require(
        {row["query_id"].strip() for row in blocking_rows} <= QUERY_IDS,
        "blocking fixture references an unknown query",
    )
    require(
        all(int(row["blocking_session_id"]) > 0 for row in blocking_rows),
        "blocking fixture must identify the blocker",
    )

    for query_id in sorted(QUERY_IDS):
        plan_path = ROOT / f"evidence/query-plans/{query_id}.sqlplan"
        root = ET.parse(plan_path).getroot()
        statements = " ".join(
            element.attrib.get("StatementText", "") for element in root.iter()
        )
        require(query_id in statements, f"{query_id} plan does not identify its query")
    checks.append("evidence fixtures")

    require("mssql/server:2022-latest" in compose, "compose must use SQL Server 2022")
    require("platform: linux/amd64" in compose, "compose must state its architecture constraint")
    checks.append("local SQL Server manifest")
    return checks


def completed(relative_path: str, minimum_length: int = 120) -> str:
    content = read(relative_path)
    lowered = content.lower()
    require(len(content.strip()) >= minimum_length, f"{relative_path} is still a stub")
    require(
        not any(placeholder in lowered for placeholder in PLACEHOLDERS),
        f"{relative_path} still contains starter placeholders",
    )
    return content


def verify_submission() -> list[str]:
    checks = verify_starter()
    baseline = completed("deliverables/baseline.md", 350)
    diagnosis = completed("deliverables/diagnosis.md", 350)
    migration_plan = completed("deliverables/migration-plan.md", 350)
    runbook = completed("deliverables/operations-runbook.md", 500)
    for query_id in QUERY_IDS:
        require(query_id in baseline, f"baseline does not cover {query_id}")
        require(query_id in diagnosis, f"diagnosis does not cover {query_id}")
    require("logical read" in baseline.lower(), "baseline must record logical reads")
    require("rollback" in runbook.lower(), "runbook must include rollback")
    require("reconcil" in runbook.lower(), "runbook must include reconciliation")
    require("azure sql" in migration_plan.lower(), "migration plan must state Azure SQL assumptions")
    checks.append("participant evidence and runbook")

    tuned = completed("sql/solution/100_tuned_queries.sql", 500)
    indexes = completed("sql/solution/110_indexes.sql", 150)
    require(query_ids(tuned) == QUERY_IDS, "tuned SQL must label Q1 through Q4")
    require(tuned.upper().count("SELECT") >= 4, "tuned SQL must include four result-producing queries")
    require("CREATE" in indexes.upper() and "INDEX" in indexes.upper(), "index script creates no index")
    require("DROP TABLE" not in indexes.upper(), "index script must not drop transactional tables")
    checks.append("tuned queries and indexes")

    expand = completed("sql/migrations/200_expand.sql", 180)
    backfill = completed("sql/migrations/210_backfill.sql", 220)
    contract = completed("sql/migrations/220_contract.sql", 180)
    rollback = completed("sql/migrations/230_rollback.sql", 180)
    reconciliation = completed("sql/migrations/240_reconciliation.sql", 220)
    require("EmailAddress" in expand and "ADD" in expand.upper(), "expand must add EmailAddress")
    require("DROP COLUMN Email" not in expand, "expand must preserve the old Email column")
    require("UPDATE" in backfill.upper(), "backfill must update existing rows")
    require(
        "TOP" in backfill.upper() or "ROWCOUNT" in backfill.upper(),
        "backfill must show a bounded batch",
    )
    require("EmailAddress" in contract, "contract step must target EmailAddress")
    require("Email" in rollback, "rollback must restore the old Email write path")
    for term in ("NULL", "duplicate", "mismatch"):
        require(term.lower() in reconciliation.lower(), f"reconciliation must cover {term}")
    checks.append("expand, backfill, contract, rollback, and reconciliation")

    monitoring = completed("sql/monitoring/300_health_checks.sql", 350)
    for dmv in ("dm_exec_requests", "dm_exec_query_stats", "dm_db_index_usage_stats"):
        require(dmv in monitoring, f"monitoring script must query {dmv}")
    checks.append("monitoring queries")
    return checks


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--mode", choices=("starter", "submission"), default="starter")
    args = parser.parse_args()
    try:
        checks = verify_submission() if args.mode == "submission" else verify_starter()
    except (VerificationError, KeyError, ValueError, ET.ParseError) as error:
        print(f"FAIL: {error}", file=sys.stderr)
        return 1
    for check in checks:
        print(f"PASS: {check}")
    print(f"Verified {len(checks)} artifact groups in {args.mode} mode.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
