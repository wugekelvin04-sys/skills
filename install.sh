#!/bin/bash

SKILLS_DIR="$(cd "$(dirname "$0")" && pwd)"

mkdir -p ~/.claude/skills ~/.claude/commands

for skill_dir in "$SKILLS_DIR/skills"/*/; do
  name=$(basename "$skill_dir")
  target="$HOME/.claude/skills/$name"
  if [ -L "$target" ] || [ -e "$target" ]; then
    echo "skip: ~/.claude/skills/$name already exists"
  else
    ln -s "$skill_dir" "$target"
    echo "linked: ~/.claude/skills/$name"
  fi
done

for cmd_file in "$SKILLS_DIR/commands"/*.md; do
  name=$(basename "$cmd_file")
  target="$HOME/.claude/commands/$name"
  if [ -L "$target" ] || [ -e "$target" ]; then
    echo "skip: ~/.claude/commands/$name already exists"
  else
    ln -s "$cmd_file" "$target"
    echo "linked: ~/.claude/commands/$name"
  fi
done

echo "done"
