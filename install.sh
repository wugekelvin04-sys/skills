#!/bin/bash

SKILLS_DIR="$(cd "$(dirname "$0")" && pwd)"

link_skill() {
  local src="$1"
  local dest_dir="$2"
  local name
  name=$(basename "$src")
  local target="$dest_dir/$name"
  if [ -L "$target" ] || [ -e "$target" ]; then
    echo "skip: $target already exists"
  else
    ln -s "$src" "$target"
    echo "linked: $target"
  fi
}

link_file() {
  local src="$1"
  local dest_dir="$2"
  local name
  name=$(basename "$src")
  local target="$dest_dir/$name"
  if [ -L "$target" ] || [ -e "$target" ]; then
    echo "skip: $target already exists"
  else
    ln -s "$src" "$target"
    echo "linked: $target"
  fi
}

# Claude Code
mkdir -p ~/.claude/skills ~/.claude/commands
for skill_dir in "$SKILLS_DIR/skills"/*/; do
  link_skill "$skill_dir" "$HOME/.claude/skills"
done
for cmd_file in "$SKILLS_DIR/commands"/*.md; do
  link_file "$cmd_file" "$HOME/.claude/commands"
done

# Codex
if command -v codex &>/dev/null || [ -d "$HOME/.agents" ]; then
  mkdir -p ~/.agents/skills
  for skill_dir in "$SKILLS_DIR/skills"/*/; do
    link_skill "$skill_dir" "$HOME/.agents/skills"
  done
fi

# Gemini CLI
if command -v gemini &>/dev/null || [ -d "$HOME/.gemini" ]; then
  mkdir -p ~/.gemini/skills
  for skill_dir in "$SKILLS_DIR/skills"/*/; do
    link_skill "$skill_dir" "$HOME/.gemini/skills"
  done
fi

# Trae (ByteDance IDE) - uses ~/.trae/skills if it exists or trae is installed
if command -v trae &>/dev/null || [ -d "$HOME/.trae" ]; then
  mkdir -p ~/.trae/skills
  for skill_dir in "$SKILLS_DIR/skills"/*/; do
    link_skill "$skill_dir" "$HOME/.trae/skills"
  done
fi

echo "done"
