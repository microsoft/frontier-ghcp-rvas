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
#   ./scripts/setup-challenge.sh challenge-11-mumps-banking
#
# When called from a devcontainer's postCreateCommand the name is
# passed automatically -- users don't need to do anything.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

# shellcheck source=_clean-common.sh
source "$REPO_ROOT/scripts/_clean-common.sh"

# ── Mapping tables ──────────────────────────────────────────────────
# Each devcontainer folder name maps to:
#   CHALLENGE_DIR   -- folder under challenges/
#   TRACK_FILE_NAME -- base name for the .md file under tracks/
#   TRACK_DIR_NAME  -- subfolder under tracks/ for the phase docs
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
  [challenge-6-agentic-workflows]="challenge-6-agentic-workflows"
  [challenge-7-copilot-sdk]="challenge-7-copilot-sdk"
  [challenge-8-flight-delay]="challenge-8-flight-delay"
  [challenge-9-team-sprint]="challenge-9-team-sprint"
  [challenge-10-tech-sprint]="challenge-10-tech-sprint"
  [challenge-11-mumps-banking]="challenge-11-mumps-banking"
  [challenge-12-legacy-modernization]="challenge-12-legacy-modernization"
  [challenge-13-living-docs]="challenge-13-living-docs"
  [challenge-14-pipeline-factory]="challenge-14-pipeline-factory"
  [challenge-15-backlog-generator]="challenge-15-backlog-generator"
  [challenge-16-ops-assistant]="challenge-16-ops-assistant"
  [challenge-17-spec-to-ship]="challenge-17-spec-to-ship"
  [challenge-18-cobol-banking]="challenge-18-cobol-banking"
  [challenge-19-wcf-banking]="challenge-19-wcf-banking"
  [challenge-21-azure-terraform]="challenge-21-azure-terraform"
)

declare -A TRACK_FILE_MAP=(
  [challenge-0-product-planning]="product-owner-track"
  [challenge-1-backend]="backend-developer-track"
  [challenge-2-data-science]="data-science-ml-track"
  [challenge-3-devops]="devops-platform-track"
  [challenge-4-frontend]="frontend-developer-track"
  [challenge-5-qa]="qa-tester-track"
  [challenge-6-agentic-workflows]="agentic-workflows-track"
  [challenge-7-copilot-sdk]="challenge-7-copilot-sdk-track"
  [challenge-8-flight-delay]="challenge-8-flight-delay-track"
  [challenge-9-team-sprint]="challenge-9-team-sprint-track"
  [challenge-10-tech-sprint]="challenge-10-tech-sprint-track"
  [challenge-11-mumps-banking]="challenge-11-mumps-modernization-track"
  [challenge-12-legacy-modernization]="challenge-12-legacy-modernization-track"
  [challenge-13-living-docs]="challenge-13-living-docs-track"
  [challenge-14-pipeline-factory]="challenge-14-pipeline-factory-track"
  [challenge-15-backlog-generator]="challenge-15-backlog-generator-track"
  [challenge-16-ops-assistant]="challenge-16-ops-assistant-track"
  [challenge-17-spec-to-ship]="challenge-17-spec-to-ship-track"
  [challenge-18-cobol-banking]="challenge-18-cobol-modernization-track"
  [challenge-19-wcf-banking]="challenge-19-wcf-modernization-track"
  [challenge-21-azure-terraform]="challenge-21-azure-terraform-track"
)

declare -A TRACK_DIR_MAP=(
  [challenge-0-product-planning]="product-owner-track"
  [challenge-1-backend]="backend-developer-track"
  [challenge-2-data-science]="data-science-ml-track"
  [challenge-3-devops]="devops-platform-track"
  [challenge-4-frontend]="frontend-developer-track"
  [challenge-5-qa]="qa-tester-track"
  [challenge-6-agentic-workflows]="agentic-workflows-track"
  [challenge-7-copilot-sdk]="challenge-7-copilot-sdk-track"
  [challenge-8-flight-delay]="challenge-8-flight-delay-track"
  [challenge-9-team-sprint]="challenge-9-team-sprint-track"
  [challenge-10-tech-sprint]="challenge-10-tech-sprint-track"
  [challenge-11-mumps-banking]="challenge-11-mumps-modernization-track"
  [challenge-12-legacy-modernization]="challenge-12-legacy-modernization-track"
  [challenge-13-living-docs]="challenge-13-living-docs-track"
  [challenge-14-pipeline-factory]="challenge-14-pipeline-factory-track"
  [challenge-15-backlog-generator]="challenge-15-backlog-generator-track"
  [challenge-16-ops-assistant]="challenge-16-ops-assistant-track"
  [challenge-17-spec-to-ship]="challenge-17-spec-to-ship-track"
  [challenge-18-cobol-banking]="challenge-18-cobol-modernization-track"
  [challenge-19-wcf-banking]="challenge-19-wcf-modernization-track"
  [challenge-21-azure-terraform]="challenge-21-azure-terraform-track"
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
TRACK_FILE_NAME="${TRACK_FILE_MAP[$CHALLENGE_KEY]}"
TRACK_DIR_NAME="${TRACK_DIR_MAP[$CHALLENGE_KEY]}"
TRACK_FILE_PATH="$REPO_ROOT/tracks/${TRACK_FILE_NAME}.md"
TRACK_DIR_PATH="$REPO_ROOT/tracks/$TRACK_DIR_NAME"
TRACK_ASSETS_PRESENT=false

if [[ -f "$TRACK_FILE_PATH" || -d "$TRACK_DIR_PATH" ]]; then
  TRACK_ASSETS_PRESENT=true
fi

echo "=== Challenge Setup: $CHALLENGE_KEY ==="
echo ""
echo "  Challenge folder: challenges/$CHALLENGE_DIR"
echo "  Track file:       tracks/$TRACK_FILE_NAME.md"
echo "  Track folder:     tracks/$TRACK_DIR_NAME"
echo "  DevContainer:     .devcontainer/$CHALLENGE_KEY"
echo ""

# ── Clean .github and non-participant artifacts ─────────────────────

clean_github_and_meta

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
if [[ "$TRACK_ASSETS_PRESENT" == true ]]; then
  KEEP_TRACK_FILES=(
    "getting-started.md"
    "${TRACK_FILE_NAME}.md"
  )

  for item in "$REPO_ROOT"/tracks/*; do
    item_name="$(basename "$item")"

    # Check if it's the track subfolder we need
    if [[ "$item_name" == "$TRACK_DIR_NAME" && -d "$item" ]]; then
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
else
  echo "[WARN] Track content for $CHALLENGE_KEY is not in tracks/ yet -- leaving tracks/ intact"
fi

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

if [[ "$TRACK_ASSETS_PRESENT" == true ]]; then
  cat > "$REPO_ROOT/README.md" <<EOF
# GitHub Copilot Enterprise Hackathon

This workspace is set up for your challenge. Everything you don't need
has been removed so you can focus on the task at hand.

## Your Track

**[Start here: tracks/${TRACK_FILE_NAME}.md](tracks/${TRACK_FILE_NAME}.md)**

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
else
  cat > "$REPO_ROOT/README.md" <<EOF
# GitHub Copilot Enterprise Hackathon

This workspace is set up for your challenge. The starter files are ready
under \
\`challenges/${CHALLENGE_DIR}/\`, and the shared docs were left in place
because the dedicated track guide has not been added to \`tracks/\` yet.

## Start Here

1. Open \`challenges/${CHALLENGE_DIR}/\`
2. Read [Getting Started](tracks/getting-started.md)
3. Use the shared docs in \`docs/\` if you need Copilot or Azure setup help

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
fi
echo "[OK] Replaced root README.md"

# ── Summary ─────────────────────────────────────────────────────────

echo ""
echo "Done. Your workspace is ready for: $CHALLENGE_KEY"
echo ""
echo "Next steps:"
echo "  1. Read tracks/$TRACK_FILE_NAME.md for the full challenge walkthrough"
echo "  2. Start with tracks/getting-started.md if this is your first time"
