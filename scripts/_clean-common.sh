#!/usr/bin/env bash
#
# _clean-common.sh -- Shared cleanup logic for clean-start.sh and setup-challenge.sh.
#
# This file is meant to be sourced, not executed directly.
# Requires REPO_ROOT to be set before sourcing.

clean_github_and_meta() {
  # ── Clean .github ───────────────────────────────────────────────────

  local github_dir="$REPO_ROOT/.github"
  mkdir -p "$github_dir"

  local instructions_file="$REPO_ROOT/.github/copilot-instructions.md"
  > "$instructions_file"
  echo "[OK] Created empty .github/copilot-instructions.md"

  local agents_dir="$REPO_ROOT/.github/agents"
  mkdir -p "$agents_dir"
  find "$agents_dir" -mindepth 1 -maxdepth 1 ! -name '.gitkeep' \
    -exec rm -rf -- {} +
  echo "[OK] Reset .github/agents/"

  local skills_dir="$REPO_ROOT/.github/skills"
  mkdir -p "$skills_dir"
  find "$skills_dir" -mindepth 1 -maxdepth 1 ! -name '.gitkeep' \
    -exec rm -rf -- {} +
  echo "[OK] Reset .github/skills/"

  local workflows_dir="$REPO_ROOT/.github/workflows"
  if [[ -d "$workflows_dir" ]]; then
    rm -rf "${workflows_dir:?}"
    echo "[OK] Removed .github/workflows/"
  else
    echo "[SKIP] .github/workflows/ not found"
  fi

  local prompts_dir="$REPO_ROOT/.github/prompts"
  if [[ -d "$prompts_dir" ]]; then
    rm -rf "${prompts_dir:?}"
    echo "[OK] Removed .github/prompts/"
  else
    echo "[SKIP] .github/prompts/ not found"
  fi

  # ── Clean non-participant top-level directories and files ───────────

  # Note: byoc/ (Bring Your Own Challenge kit) is intentionally
  # NOT removed here. It is facilitator-facing reference material and is
  # preserved by design in participant workspaces for context about the
  # outcome-driven model.

  if [[ -d "$REPO_ROOT/.copilot" ]]; then
    rm -rf "$REPO_ROOT/.copilot"
    echo "[OK] Removed .copilot/"
  else
    echo "[SKIP] .copilot/ not found"
  fi

  if [[ -d "$REPO_ROOT/.squad" ]]; then
    rm -rf "$REPO_ROOT/.squad"
    echo "[OK] Removed .squad/"
  else
    echo "[SKIP] .squad/ not found"
  fi

  if [[ -d "$REPO_ROOT/.playwright-mcp" ]]; then
    rm -rf "$REPO_ROOT/.playwright-mcp"
    echo "[OK] Removed .playwright-mcp/"
  else
    echo "[SKIP] .playwright-mcp/ not found"
  fi

  if [[ -f "$REPO_ROOT/.gitattributes" ]]; then
    rm -f "$REPO_ROOT/.gitattributes"
    echo "[OK] Removed .gitattributes"
  else
    echo "[SKIP] .gitattributes not found"
  fi

  # ── Remove git remote origin ────────────────────────────────────────

  if git -C "$REPO_ROOT" remote get-url origin &>/dev/null; then
    local remote_url
    remote_url=$(git -C "$REPO_ROOT" remote get-url origin)
    git -C "$REPO_ROOT" remote remove origin
    echo "[OK] Removed git remote 'origin' (was: $remote_url)"
  else
    echo "[SKIP] No git remote 'origin' found"
  fi
}
