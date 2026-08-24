#!/usr/bin/env python3

import argparse
import csv
import re
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]

STARTER_FILES = [
    "evidence/merger-brief.md",
    "evidence/system-inventory.csv",
    "evidence/capability-overlap.csv",
    "evidence/ownership-conflicts.csv",
    "evidence/volumes-and-slos.csv",
    "evidence/nfr-and-compliance.md",
    "evidence/integration-failure-evidence.md",
    "evidence/stakeholder-priorities.md",
    "evidence/contracts/customer-profile-api.yaml",
    "evidence/contracts/order-lifecycle-events.yaml",
    "templates/capability-boundary-map.md",
    "templates/architecture-context.mmd",
    "templates/architecture-containers.mmd",
    "templates/adr-template.md",
    "templates/integration-contract.yaml",
    "templates/migration-roadmap.md",
]

DELIVERABLE_FILES = [
    "deliverables/capability-boundary-map.md",
    "deliverables/architecture-context.mmd",
    "deliverables/architecture-containers.mmd",
    "deliverables/integration-contract.yaml",
    "deliverables/migration-roadmap.md",
]

REQUIRED_CONTRACT_KEYS = {
    "name",
    "version",
    "owner",
    "purpose",
    "interaction",
    "source_of_record",
    "conflict_rule",
    "latency_target",
    "availability_target",
    "idempotency_key",
    "retry_policy",
    "versioning_rule",
    "breaking_change_approval",
    "correlation_field",
    "retention",
    "deletion_handling",
}


class Validator:
    def __init__(self) -> None:
        self.errors: list[str] = []
        self.checks = 0

    def check(self, condition: bool, message: str) -> None:
        self.checks += 1
        if not condition:
            self.errors.append(message)

    def text(self, relative: str) -> str:
        path = ROOT / relative
        self.check(path.is_file(), f"Missing file: {relative}")
        return path.read_text(encoding="utf-8") if path.is_file() else ""

    def report(self) -> int:
        if self.errors:
            print(f"Validation failed with {len(self.errors)} issue(s):")
            for error in self.errors:
                print(f"- {error}")
            return 1
        print(f"Validation passed: {self.checks} checks")
        return 0


def check_csv(validator: Validator, relative: str, required_columns: set[str]) -> None:
    path = ROOT / relative
    if not path.is_file():
        validator.check(False, f"Missing CSV: {relative}")
        return
    with path.open(encoding="utf-8", newline="") as handle:
        reader = csv.DictReader(handle)
        validator.check(
            required_columns.issubset(set(reader.fieldnames or [])),
            f"{relative} is missing required columns",
        )
        validator.check(any(reader), f"{relative} has no evidence rows")


def check_yaml_shape(validator: Validator, relative: str, required_roots: set[str]) -> None:
    text = validator.text(relative)
    if not text:
        return
    validator.check("\t" not in text, f"{relative} uses tabs for YAML indentation")
    roots = {
        match.group(1)
        for line in text.splitlines()
        if (match := re.match(r"^([A-Za-z][A-Za-z0-9_-]*):(?:\s|$)", line))
    }
    validator.check(
        required_roots.issubset(roots),
        f"{relative} is missing required root keys: {sorted(required_roots - roots)}",
    )
    for number, line in enumerate(text.splitlines(), start=1):
        stripped = line.strip()
        if stripped and not stripped.startswith(("#", "-")):
            validator.check(":" in stripped, f"{relative}:{number} is not a YAML key/value line")


def check_mermaid(validator: Validator, relative: str, allow_todo: bool) -> None:
    text = validator.text(relative)
    if not text:
        return
    source = "\n".join(
        line for line in text.splitlines() if not line.strip().startswith("%%")
    ).strip()
    validator.check(
        bool(re.match(r"^(flowchart|graph|sequenceDiagram|C4Context|C4Container)\b", source)),
        f"{relative} has no recognized Mermaid diagram declaration",
    )
    for opening, closing in (("[", "]"), ("(", ")"), ("{", "}")):
        validator.check(
            source.count(opening) == source.count(closing),
            f"{relative} has unbalanced {opening}{closing} delimiters",
        )
    validator.check("-->" in source or "Rel(" in source, f"{relative} has no relationships")
    if not allow_todo:
        validator.check("TODO" not in text, f"{relative} still contains TODO placeholders")


def validate_starter() -> int:
    validator = Validator()
    for relative in STARTER_FILES:
        validator.text(relative)
    check_csv(
        validator,
        "evidence/system-inventory.csv",
        {"system_id", "organization", "capabilities", "owner", "data_authority"},
    )
    check_csv(
        validator,
        "evidence/ownership-conflicts.csv",
        {"subject", "HPC_claim", "NMN_claim", "decision_needed_by"},
    )
    check_csv(
        validator,
        "evidence/volumes-and-slos.csv",
        {"flow", "normal_volume", "peak_volume", "availability", "recovery_objective"},
    )
    check_yaml_shape(
        validator,
        "evidence/contracts/customer-profile-api.yaml",
        {"openapi", "info", "paths", "components"},
    )
    check_yaml_shape(
        validator,
        "evidence/contracts/order-lifecycle-events.yaml",
        {"asyncapi", "info", "channels", "components"},
    )
    check_yaml_shape(validator, "templates/integration-contract.yaml", {"contract"})
    check_mermaid(validator, "templates/architecture-context.mmd", allow_todo=True)
    check_mermaid(validator, "templates/architecture-containers.mmd", allow_todo=True)
    return validator.report()


def validate_adrs(validator: Validator) -> None:
    directory = ROOT / "deliverables/adrs"
    validator.check(directory.is_dir(), "Missing directory: deliverables/adrs")
    if not directory.is_dir():
        return
    files = sorted(directory.glob("ADR-[0-9][0-9][0-9][0-9]-*.md"))
    validator.check(3 <= len(files) <= 4, "Provide 3 or 4 ADR files")
    seen_ids: set[str] = set()
    for path in files:
        text = path.read_text(encoding="utf-8")
        match = re.search(r"^# (ADR-\d{4}): .+", text, flags=re.MULTILINE)
        validator.check(bool(match), f"{path.name} needs an ADR-NNNN title")
        if match:
            validator.check(match.group(1) not in seen_ids, f"Duplicate ADR ID: {match.group(1)}")
            seen_ids.add(match.group(1))
        validator.check(
            bool(re.search(r"^- \*\*Status:\*\* (Proposed|Accepted|Superseded|Rejected)$", text, re.MULTILINE)),
            f"{path.name} has an invalid or missing status",
        )
        for heading in ("## Context", "## Options considered", "## Decision", "## Consequences"):
            validator.check(heading in text, f"{path.name} is missing {heading}")
        validator.check("TODO" not in text, f"{path.name} still contains TODO placeholders")


def validate_contract(validator: Validator) -> None:
    relative = "deliverables/integration-contract.yaml"
    text = validator.text(relative)
    if not text:
        return
    validator.check("\t" not in text, f"{relative} uses tabs for indentation")
    found = {
        match.group(1)
        for line in text.splitlines()
        if (match := re.match(r"^\s*([A-Za-z][A-Za-z0-9_-]*):\s*(.*)$", line))
        and match.group(2).strip()
        and match.group(2).strip() != "TODO"
    }
    missing = REQUIRED_CONTRACT_KEYS - found
    validator.check(not missing, f"{relative} has blank or missing keys: {sorted(missing)}")
    validator.check("TODO" not in text, f"{relative} still contains TODO placeholders")


def validate_submission() -> int:
    validator = Validator()
    for relative in DELIVERABLE_FILES:
        text = validator.text(relative)
        if text:
            validator.check("TODO" not in text, f"{relative} still contains TODO placeholders")
    check_mermaid(validator, "deliverables/architecture-context.mmd", allow_todo=False)
    check_mermaid(validator, "deliverables/architecture-containers.mmd", allow_todo=False)
    validate_adrs(validator)
    validate_contract(validator)
    roadmap = validator.text("deliverables/migration-roadmap.md")
    if roadmap:
        for phrase in ("Transition states", "Delivery waves", "Rollback", "Risk register"):
            validator.check(phrase.lower() in roadmap.lower(), f"Roadmap is missing {phrase}")
    boundary_map = validator.text("deliverables/capability-boundary-map.md")
    if boundary_map:
        for phrase in ("Capability map", "Authority", "Boundary rules"):
            validator.check(phrase.lower() in boundary_map.lower(), f"Boundary map is missing {phrase}")
    return validator.report()


def main() -> int:
    parser = argparse.ArgumentParser(description="Validate Challenge 23 architecture artifacts.")
    parser.add_argument(
        "--starter",
        action="store_true",
        help="Validate the evidence pack and templates instead of participant deliverables.",
    )
    args = parser.parse_args()
    return validate_starter() if args.starter else validate_submission()


if __name__ == "__main__":
    sys.exit(main())
