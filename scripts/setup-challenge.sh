#!/usr/bin/env bash
#
# setup-challenge.sh -- Prepare the workspace for a single challenge.
#
# Keeps only the challenge folder, track files, and devcontainer config
# needed for the given challenge. Everything else is removed so users
# see a clean, focused workspace.
#
# Also runs the clean-start logic (empties copilot-instructions.md,
# removes sample agents/skills, detaches the git remote).
#
# Usage:
#   ./scripts/setup-challenge.sh <devcontainer-folder-name>
#
# Examples:
#   ./scripts/setup-challenge.sh challenge-1-backend
#   ./scripts/setup-challenge.sh bonus-5-mumps-banking
#
# When called from a devcontainer's postCreateCommand the name is
# passed automatically -- users don't need to do anything.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

# ── Mapping tables ──────────────────────────────────────────────────
# Each devcontainer folder name maps to:
#   CHALLENGE_DIR  -- folder under challenges/
#   TRACK_NAME     -- base name for the .md file and subfolder under tracks/
#
# Entries where the devcontainer name differs from the challenge folder
# or where the track name follows a different convention are spelled out.

declare -A CHALLENGE_MAP=(
  [challenge-0-product-planning]="challenge-0-product-planning"
  [challenge-1-backend]="challenge-1-web-api"
  [challenge-2-data-science]="challenge-2-ml-ai"
  [challenge-3-devops]="challenge-3-devops"
  [challenge-4-frontend]="challenge-4-frontend"
  [challenge-5-qa]="challenge-5-qa"
  [bonus-1-copilot-sdk]="bonus-1-copilot-sdk"
  [bonus-2-flight-delay]="bonus-2-flight-delay"
  [bonus-3-team-sprint]="bonus-3-team-sprint"
  [bonus-4-tech-sprint]="bonus-4-tech-sprint"
  [bonus-5-mumps-banking]="bonus-5-mumps-banking"
  [bonus-6-legacy-modernization]="bonus-6-legacy-modernization"
  [bonus-7-living-docs]="bonus-7-living-docs"
  [bonus-8-pipeline-factory]="bonus-8-pipeline-factory"
  [bonus-9-backlog-generator]="bonus-9-backlog-generator"
  [bonus-10-ops-assistant]="bonus-10-ops-assistant"
  [bonus-11-spec-to-ship]="bonus-11-spec-to-ship"
)

declare -A TRACK_MAP=(
  [challenge-0-product-planning]="product-owner-track"
  [challenge-1-backend]="backend-developer-track"
  [challenge-2-data-science]="data-science-ml-track"
  [challenge-3-devops]="devops-platform-track"
  [challenge-4-frontend]="frontend-developer-track"
  [challenge-5-qa]="qa-tester-track"
  [bonus-1-copilot-sdk]="bonus-copilot-sdk-track"
  [bonus-2-flight-delay]="bonus-flight-delay-track"
  [bonus-3-team-sprint]="bonus-team-sprint-track"
  [bonus-4-tech-sprint]="bonus-tech-sprint-track"
  [bonus-5-mumps-banking]="bonus-mumps-modernization-track"
  [bonus-6-legacy-modernization]="bonus-legacy-modernization-track"
  [bonus-7-living-docs]="bonus-living-docs-track"
  [bonus-8-pipeline-factory]="bonus-pipeline-factory-track"
  [bonus-9-backlog-generator]="bonus-backlog-generator-track"
  [bonus-10-ops-assistant]="bonus-ops-assistant-track"
  [bonus-11-spec-to-ship]="bonus-spec-to-ship-track"
)

# ── Validate input ──────────────────────────────────────────────────

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <challenge-name>"
  echo ""
  echo "Available challenges:"
  printf "  %s\n" "${!CHALLENGE_MAP[@]}" | sort
  exit 1
fi

CHALLENGE_KEY="$1"

if [[ -z "${CHALLENGE_MAP[$CHALLENGE_KEY]+x}" ]]; then
  echo "Error: unknown challenge '$CHALLENGE_KEY'"
  echo ""
  echo "Available challenges:"
  printf "  %s\n" "${!CHALLENGE_MAP[@]}" | sort
  exit 1
fi

CHALLENGE_DIR="${CHALLENGE_MAP[$CHALLENGE_KEY]}"
TRACK_NAME="${TRACK_MAP[$CHALLENGE_KEY]}"

echo "=== Challenge Setup: $CHALLENGE_KEY ==="
echo ""
echo "  Challenge folder: challenges/$CHALLENGE_DIR"
echo "  Track:            tracks/$TRACK_NAME.md"
echo "  DevContainer:     .devcontainer/$CHALLENGE_KEY"
echo ""

# ── Clean .github (same as clean-start.sh) ──────────────────────────

INSTRUCTIONS_FILE="$REPO_ROOT/.github/copilot-instructions.md"
if [[ -f "$INSTRUCTIONS_FILE" ]]; then
  > "$INSTRUCTIONS_FILE"
  echo "[OK] Cleared .github/copilot-instructions.md"
fi

AGENTS_DIR="$REPO_ROOT/.github/agents"
if [[ -d "$AGENTS_DIR" ]]; then
  find "$AGENTS_DIR" -type f ! -name '.gitkeep' -delete 2>/dev/null || true
  echo "[OK] Removed sample agents from .github/agents/"
fi

SKILLS_DIR="$REPO_ROOT/.github/skills"
if [[ -d "$SKILLS_DIR" ]]; then
  rm -rf "${SKILLS_DIR:?}"/* 2>/dev/null || true
  echo "[OK] Removed sample skills from .github/skills/"
fi

if git -C "$REPO_ROOT" remote get-url origin &>/dev/null; then
  git -C "$REPO_ROOT" remote remove origin
  echo "[OK] Removed git remote 'origin'"
fi

# ── Remove unrelated challenge folders ──────────────────────────────

echo ""
for dir in "$REPO_ROOT"/challenges/*/; do
  dir_name="$(basename "$dir")"
  if [[ "$dir_name" != "$CHALLENGE_DIR" ]]; then
    rm -rf "$dir"
    echo "[CLEAN] Removed challenges/$dir_name"
  fi
done

# ── Remove unrelated track files and folders ────────────────────────

# Keep: getting-started.md and the specific track .md + subfolder.
# README.md and TRACK_STRUCTURE.md are removed -- they reference all
# tracks and are a contributor guide, respectively.
KEEP_TRACK_FILES=(
  "getting-started.md"
  "${TRACK_NAME}.md"
)

for item in "$REPO_ROOT"/tracks/*; do
  item_name="$(basename "$item")"

  # Check if it's the track subfolder we need
  if [[ "$item_name" == "$TRACK_NAME" && -d "$item" ]]; then
    continue
  fi

  # Check if it's one of the files we always keep
  keep=false
  for keep_file in "${KEEP_TRACK_FILES[@]}"; do
    if [[ "$item_name" == "$keep_file" ]]; then
      keep=true
      break
    fi
  done

  if [[ "$keep" == false ]]; then
    rm -rf "$item"
    echo "[CLEAN] Removed tracks/$item_name"
  fi
done

# ── Remove unrelated devcontainer configs ───────────────────────────

for dir in "$REPO_ROOT"/.devcontainer/*/; do
  dir_name="$(basename "$dir")"
  if [[ "$dir_name" != "$CHALLENGE_KEY" ]]; then
    rm -rf "$dir"
    echo "[CLEAN] Removed .devcontainer/$dir_name"
  fi
done

# Update .devcontainer/README.md to only reference this challenge
cat > "$REPO_ROOT/.devcontainer/README.md" <<EOF
# DevContainer Configuration

This workspace is configured for **$CHALLENGE_KEY**.

The devcontainer setup has already installed all prerequisites and
cleaned up files from other challenges.
EOF
echo "[OK] Updated .devcontainer/README.md"

# ── Remove files that are not for participants ─────────────────────

for remove_file in FACILITATOR_GUIDE.md CONTRIBUTING.md; do
  if [[ -f "$REPO_ROOT/$remove_file" ]]; then
    rm -f "$REPO_ROOT/$remove_file"
    echo "[CLEAN] Removed $remove_file"
  fi
done

# ── Replace root README with a focused version ──────────────────────

cat > "$REPO_ROOT/README.md" <<EOF
# GitHub Copilot Enterprise Hackathon

This workspace is set up for your challenge. Everything you don't need
has been removed so you can focus on the task at hand.

## Your Track

**[Start here: tracks/${TRACK_NAME}.md](tracks/${TRACK_NAME}.md)**

If this is your first time, read [Getting Started](tracks/getting-started.md) first.

## Quick Copilot Check

Before you begin, verify Copilot is working:

1. Look at the bottom-right of VS Code -- the Copilot icon should say "Ready"
2. Press \`Ctrl+Shift+I\` (or \`Cmd+Shift+I\` on Mac) to open Chat
3. Ask: "Hello, are you working?"

## Resources

- [Copilot Guide](docs/copilot-guide.md)
- [Prompt Engineering Guide](docs/prompt-engineering.md)
- [MCP Servers Guide](docs/mcp-servers.md)
- [Troubleshooting](TROUBLESHOOTING.md)
EOF
echo "[OK] Replaced root README.md"

# ── Summary ─────────────────────────────────────────────────────────

echo ""
echo "Done. Your workspace is ready for: $CHALLENGE_KEY"
echo ""
echo "Next steps:"
echo "  1. Read tracks/$TRACK_NAME.md for the full challenge walkthrough"
echo "  2. Start with tracks/getting-started.md if this is your first time"
