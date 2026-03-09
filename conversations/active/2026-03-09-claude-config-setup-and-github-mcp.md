# claude-config setup and github mcp

- **Date:** 2026-03-09
- **Saved:** 2026-03-09T09:00:19Z
- **Source:** manual

---

Set up ahmed-masud/claude-config repo for managing Claude settings, profiles, and conversations across sessions. Designed directory structure with system/profiles (symlink-based switching between ahmed/izza), memory, conversations (active/archive), and scripts. Ahmed split personal profile into separate private repo (claude-personal). Connected GitHub MCP server to Claude Code using fine-grained PAT scoped to claude-config via remote HTTP transport. Built claude-cli — a standalone CLI tool for saving conversations, switching profiles, syncing to GitHub, and checking status. Added scripts to PATH via .zshrc. Corrected daughters' ages in memory (Laila 11, Ava 9). Everything synced and verified between web Claude and CLI.
