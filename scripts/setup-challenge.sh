#!/usr/bin/env bash
#
# setup-challenge.sh -- Prepare the workspace for a single challenge.
#
# Keeps the selected challenge and its guides, removing template-only material.
# Repeat setup preserves participant files and Copilot customizations.
#
# Also runs the clean-start logic (creates empty repository instructions,
# agent, and skill locations; removes samples; keeps git remotes).
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

# shellcheck source=scripts/_clean-common.sh
source "$REPO_ROOT/scripts/_clean-common.sh"

# ── Mapping tables ──────────────────────────────────────────────────
# Each devcontainer folder name maps to:
#   CHALLENGE_DIR   -- folder under challenges/
#   TRACK_FILE_NAME -- base name for the .md file under tracks/
#   TRACK_DIR_NAME  -- subfolder under tracks/ for the stage docs
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
  [challenge-20-powershell-automation]="challenge-20-powershell-automation"
  [challenge-21-azure-terraform]="challenge-21-azure-terraform"
  [challenge-22-secure-release]="challenge-22-secure-release"
  [challenge-23-merger-architecture]="challenge-23-merger-architecture"
  [challenge-24-database-rescue]="challenge-24-database-rescue"
  [challenge-25-api-guardrails]="challenge-25-api-guardrails"
  [challenge-26-developer-onboarding]="challenge-26-developer-onboarding"
  [challenge-27-offline-mobile]="challenge-27-offline-mobile"
  [challenge-28-work-iq-workplace-assistant]="challenge-28-work-iq-workplace-assistant"
  [challenge-29-inherit-and-evolve]="challenge-29-inherit-and-evolve"
  [challenge-30-spec-driven]="challenge-30-spec-driven"
)

declare -A TRACK_FILE_MAP=(
  [challenge-0-product-planning]="challenge-0-product-planning-track"
  [challenge-1-backend]="challenge-1-web-api-track"
  [challenge-2-data-science]="challenge-2-ml-ai-track"
  [challenge-3-devops]="challenge-3-devops-track"
  [challenge-4-frontend]="challenge-4-frontend-track"
  [challenge-5-qa]="challenge-5-qa-track"
  [challenge-6-agentic-workflows]="challenge-6-agentic-workflows-track"
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
  [challenge-20-powershell-automation]="challenge-20-powershell-automation-track"
  [challenge-21-azure-terraform]="challenge-21-azure-terraform-track"
  [challenge-22-secure-release]="challenge-22-secure-release-track"
  [challenge-23-merger-architecture]="challenge-23-merger-architecture-track"
  [challenge-24-database-rescue]="challenge-24-database-rescue-track"
  [challenge-25-api-guardrails]="challenge-25-api-guardrails-track"
  [challenge-26-developer-onboarding]="challenge-26-developer-onboarding-track"
  [challenge-27-offline-mobile]="challenge-27-offline-mobile-track"
  [challenge-28-work-iq-workplace-assistant]="challenge-28-work-iq-workplace-assistant-track"
  [challenge-29-inherit-and-evolve]="challenge-29-inherit-and-evolve-track"
  [challenge-30-spec-driven]="challenge-30-spec-driven-track"
)

declare -A TRACK_DIR_MAP=(
  [challenge-0-product-planning]="challenge-0-product-planning-track"
  [challenge-1-backend]="challenge-1-web-api-track"
  [challenge-2-data-science]="challenge-2-ml-ai-track"
  [challenge-3-devops]="challenge-3-devops-track"
  [challenge-4-frontend]="challenge-4-frontend-track"
  [challenge-5-qa]="challenge-5-qa-track"
  [challenge-6-agentic-workflows]="challenge-6-agentic-workflows-track"
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
  [challenge-20-powershell-automation]="challenge-20-powershell-automation-track"
  [challenge-21-azure-terraform]="challenge-21-azure-terraform-track"
  [challenge-22-secure-release]="challenge-22-secure-release-track"
  [challenge-23-merger-architecture]="challenge-23-merger-architecture-track"
  [challenge-24-database-rescue]="challenge-24-database-rescue-track"
  [challenge-25-api-guardrails]="challenge-25-api-guardrails-track"
  [challenge-26-developer-onboarding]="challenge-26-developer-onboarding-track"
  [challenge-27-offline-mobile]="challenge-27-offline-mobile-track"
  [challenge-28-work-iq-workplace-assistant]="challenge-28-work-iq-workplace-assistant-track"
  [challenge-29-inherit-and-evolve]="challenge-29-inherit-and-evolve-track"
  [challenge-30-spec-driven]="challenge-30-spec-driven-track"
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
CHALLENGE_PATH="$REPO_ROOT/challenges/$CHALLENGE_DIR"
DEVCONTAINER_PATH="$REPO_ROOT/.devcontainer/$CHALLENGE_KEY"
PREPARED_PATH="$REPO_ROOT/.devcontainer/.workspace-prepared"

if [[ -e "$PREPARED_PATH" ]]; then
  if [[ ! -f "$PREPARED_PATH" ]]; then
    echo "Error: invalid workspace marker at '$PREPARED_PATH'." >&2
    exit 1
  fi
  PREPARED_CHALLENGE="$(<"$PREPARED_PATH")"
  if [[ -z "$PREPARED_CHALLENGE" ]]; then
    echo "Error: invalid workspace marker at '$PREPARED_PATH'." >&2
    exit 1
  fi
  if [[ "$PREPARED_CHALLENGE" != "$CHALLENGE_KEY" ]]; then
    echo "Error: this workspace is prepared for '$PREPARED_CHALLENGE'. Use a fresh clone for '$CHALLENGE_KEY'." >&2
    exit 1
  fi
  echo "[SKIP] Workspace already prepared for $CHALLENGE_KEY; keeping participant files and customizations."
  exit 0
fi

MISSING_PATHS=()
[[ -d "$CHALLENGE_PATH" ]] || MISSING_PATHS+=("challenges/$CHALLENGE_DIR")
[[ -f "$TRACK_FILE_PATH" ]] || MISSING_PATHS+=("tracks/$TRACK_FILE_NAME.md")
[[ -d "$TRACK_DIR_PATH" ]] || MISSING_PATHS+=("tracks/$TRACK_DIR_NAME")
[[ -d "$DEVCONTAINER_PATH" ]] || MISSING_PATHS+=(".devcontainer/$CHALLENGE_KEY")

if (( ${#MISSING_PATHS[@]} > 0 )); then
  echo "Error: setup files are missing for '$CHALLENGE_KEY':" >&2
  printf "  %s\n" "${MISSING_PATHS[@]}" >&2
  exit 1
fi

# Older setup versions removed these files without writing a marker.
if [[ ! -e "$REPO_ROOT/tracks/README.md" && ! -e "$REPO_ROOT/CONTRIBUTING.md" ]]; then
  printf '%s\n' "$CHALLENGE_KEY" > "$PREPARED_PATH"
  echo "[SKIP] Existing participant workspace detected; keeping files and customizations."
  exit 0
fi

echo "=== Challenge Setup: $CHALLENGE_KEY ==="
echo ""
echo "  Challenge folder: challenges/$CHALLENGE_DIR"
echo "  Track file:       tracks/$TRACK_FILE_NAME.md"
echo "  Track folder:     tracks/$TRACK_DIR_NAME"
echo "  DevContainer:     .devcontainer/$CHALLENGE_KEY"
echo ""

if ! git -C "$REPO_ROOT" rev-parse --verify HEAD >/dev/null 2>&1; then
  echo "Error: setup requires a Git checkout with at least one commit. No cleanup was performed." >&2
  exit 1
fi

CHALLENGE_ID="${CHALLENGE_KEY#challenge-}"
CHALLENGE_ID="${CHALLENGE_ID%%-*}"
BRANCH_SUFFIX="$(od -An -N6 -tx1 /dev/urandom | tr -d ' \n')"
WORK_BRANCH="challenge-$CHALLENGE_ID-$BRANCH_SUFFIX"
git -C "$REPO_ROOT" switch --no-track -c "$WORK_BRANCH"
echo "[OK] Created work branch '$WORK_BRANCH'; git remotes are unchanged."

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

Setup keeps the selected challenge and its guides.
Git remotes are unchanged. Work starts on \`$WORK_BRANCH\`.
Rebuilding preserves your current branch, files, and Copilot customizations.
EOF
echo "[OK] Updated .devcontainer/README.md"

# ── Remove files that are not for participants ─────────────────────

for dir in web byoc; do
  if [[ -e "$REPO_ROOT/$dir" || -L "$REPO_ROOT/$dir" ]]; then
    rm -rf -- "${REPO_ROOT:?}/$dir"
    echo "[CLEAN] Removed $dir/"
  fi
done

for file in CONTRIBUTING.md AGENTS.md CONTEXT.md FACILITATOR_GUIDE.md \
  learning-paths.json role-collections.json docs/index.md \
  docs/challenges docs/tracks docs/TROUBLESHOOTING.md \
  scripts/setup-challenge.test.mjs; do
  if [[ -e "$REPO_ROOT/$file" || -L "$REPO_ROOT/$file" ]]; then
    rm -f -- "$REPO_ROOT/$file"
    echo "[CLEAN] Removed $file"
  fi
done

# ── Replace root README with a focused version ──────────────────────

cat > "$REPO_ROOT/README.md" <<EOF
# GitHub Copilot Adoption

**[Start your challenge](tracks/${TRACK_FILE_NAME}.md)**.

Your track explains the stages and links to the starter in
\`challenges/$CHALLENGE_DIR/\`.

Setup created \`$WORK_BRANCH\` and kept your Git remotes.
Check \`git remote -v\` before pushing. Setup does not push or commit changes.

## Setup and Help

- [Shared setup](tracks/getting-started.md)
- [Copilot Guide](docs/copilot-guide.md)
- [Prompt Engineering Guide](docs/prompt-engineering.md)
- [MCP Servers Guide](docs/mcp-servers.md)
- [Troubleshooting](TROUBLESHOOTING.md)
EOF
echo "[OK] Replaced root README.md"

printf '%s\n' "$CHALLENGE_KEY" > "$PREPARED_PATH"

# ── Summary ─────────────────────────────────────────────────────────

echo ""
echo "Done. Your workspace is ready for: $CHALLENGE_KEY"
echo ""
echo "Start with tracks/$TRACK_FILE_NAME.md."
