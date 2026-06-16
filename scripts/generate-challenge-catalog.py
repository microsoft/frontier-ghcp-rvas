#!/usr/bin/env python3
"""Generate the MkDocs challenge catalog used by the curated set pages."""

from __future__ import annotations

import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SELECTION_DOC = ROOT / "docs" / "challenge-selection.md"
TRACKS_DIR = ROOT / "tracks"
CHALLENGES_DIR = ROOT / "challenges"
OUTPUT = ROOT / "docs" / "assets" / "data" / "challenges.json"

CATEGORY_RULES = [
    (range(0, 7), "Core tracks"),
    ({9, 10}, "Team sprints"),
    ({11, 12, 18, 19}, "Legacy modernization"),
    ({13, 14, 15, 16, 17, 20}, "Workflow automation"),
    ({21}, "Azure platform"),
]

KEYWORD_TAGS = {
    "api": "api",
    "authentication": "auth",
    "azure": "azure",
    "backlog": "backlog",
    "ci/cd": "ci-cd",
    "cobol": "cobol",
    "documentation": "docs",
    "frontend": "frontend",
    "legacy": "legacy",
    "ml": "ml",
    "mumps": "mumps",
    "powershell": "powershell",
    "qa": "qa",
    "react": "react",
    "terraform": "terraform",
    "testing": "testing",
}

TABLE_ROW = re.compile(
    r"^\|\s*(?P<number>\d+)\s*\|\s*(?P<focus>.*?)\s*\|\s*"
    r"\[(?P<track_label>[^\]]+)\]\((?P<track_url>[^)]+)\)\s*\|\s*$"
)


def read_text(path: Path) -> str:
    return path.read_text(encoding="utf-8")


def plain(text: str) -> str:
    return re.sub(r"\s+", " ", text).strip()


def track_title(track_path: Path, fallback: str) -> str:
    text = read_text(track_path)
    match = re.search(r"^#\s+Challenge\s+\d+\s+Track:\s+(.+?)\s*$", text, re.MULTILINE)
    if match:
        return plain(match.group(1))
    return fallback.replace(" Track", "").strip()


def track_duration(track_path: Path) -> str:
    text = read_text(track_path)
    match = re.search(r"^\*\*Duration:\*\*\s*(.+?)\s*$", text, re.MULTILINE)
    if match:
        return plain(match.group(1))
    return ""


def track_focus(track_path: Path, fallback: str) -> str:
    text = read_text(track_path)
    match = re.search(r"^\*\*Focus:\*\*\s*(.+?)\s*$", text, re.MULTILINE)
    if match:
        return plain(match.group(1))
    return fallback


def starter_path(number: int) -> str:
    matches = sorted(CHALLENGES_DIR.glob(f"challenge-{number}-*"))
    if not matches:
        raise RuntimeError(f"No challenge folder found for challenge {number}")
    return matches[0].relative_to(ROOT).as_posix() + "/"


def category_for(number: int) -> str:
    for numbers, category in CATEGORY_RULES:
        if number in numbers:
            return category
    return "Advanced tracks"


def tags_for(number: int, title: str, focus: str, category: str) -> list[str]:
    source = f"{title} {focus} {category}".lower()
    tags = [category.lower().replace(" ", "-")]
    if number <= 6:
        tags.append("core")
    if number >= 7:
        tags.append("advanced")
    for keyword, tag in KEYWORD_TAGS.items():
        if keyword in source and tag not in tags:
            tags.append(tag)
    return tags[:6]


def parse_selection_rows() -> list[dict]:
    rows: list[dict] = []
    for line in read_text(SELECTION_DOC).splitlines():
        match = TABLE_ROW.match(line)
        if not match:
            continue
        number = int(match.group("number"))
        track_url = match.group("track_url")
        track_path = (SELECTION_DOC.parent / track_url).resolve()
        if not track_path.exists():
            raise RuntimeError(f"Track path for challenge {number} does not exist: {track_url}")
        title = track_title(track_path, match.group("track_label"))
        focus = track_focus(track_path, plain(match.group("focus")))
        category = category_for(number)
        rows.append(
            {
                "id": number,
                "number": number,
                "slug": f"challenge-{number}",
                "title": title,
                "display_title": f"Challenge {number}: {title}",
                "focus": focus,
                "selection_hint": plain(match.group("focus")),
                "duration": track_duration(track_path),
                "category": category,
                "track_url": track_url,
                "starter_path": starter_path(number),
                "tags": tags_for(number, title, focus, category),
            }
        )
    return sorted(rows, key=lambda item: item["number"])


def main() -> None:
    challenges = parse_selection_rows()
    expected = list(range(22))
    actual = [item["number"] for item in challenges]
    if actual != expected:
        raise RuntimeError(f"Expected challenge numbers 0-21, found {actual}")

    categories = []
    for challenge in challenges:
        if challenge["category"] not in categories:
            categories.append(challenge["category"])

    payload = {
        "generated_by": "scripts/generate-challenge-catalog.py",
        "source": "docs/challenge-selection.md",
        "count": len(challenges),
        "categories": categories,
        "challenges": challenges,
    }
    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT.write_text(json.dumps(payload, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
    print(f"Wrote {OUTPUT.relative_to(ROOT)} with {len(challenges)} challenges")


if __name__ == "__main__":
    main()
