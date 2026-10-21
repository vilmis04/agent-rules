#!/usr/bin/env bash
# Symlinks every skill in skills/ into the global Claude Code and Cursor skill
# directories so they are available in every repo, and stay in sync on git pull.
set -euo pipefail

REPO_SKILLS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/skills" && pwd)"
TARGET_DIRS=("$HOME/.claude/skills" "$HOME/.cursor/skills")

for target_dir in "${TARGET_DIRS[@]}"; do
  mkdir -p "$target_dir"
  for skill_dir in "$REPO_SKILLS_DIR"/*/; do
    skill_name="$(basename "$skill_dir")"
    ln -sfn "${skill_dir%/}" "$target_dir/$skill_name"
    echo "Linked $skill_name -> $target_dir/$skill_name"
  done
done
