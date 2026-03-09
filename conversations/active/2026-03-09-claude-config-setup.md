# Setting Up claude-config Repo & GitHub MCP

- **Date:** 2026-03-09
- **Source:** claude.ai (web)

---

## Summary

Set up a version-controlled GitHub repo (`ahmed-masud/claude-config`) for managing Claude settings, profiles, and conversation history across sessions.

## What We Did

1. **Designed repo structure** — `system/profiles/`, `memory/`, `conversations/`, `scripts/`
2. **Created profile system** — Ahmed and Izza profiles with symlink-based switching (`system/profiles/default -> ahmed`)
3. **Built utility scripts** — `switch-profile.sh` (profile switching with auto-commit), `sync.sh` (push/pull with timestamps)
4. **Pushed to GitHub** — `ahmed-masud/claude-config` (public), ahmed moved personal profile to `ahmed-masud/claude-personal` (private)
5. **Set up GitHub MCP server** — Fine-grained PAT scoped to `claude-config`, connected via Claude Code CLI using remote HTTP transport
6. **Created conversation save workflow** — `save-conversation.sh` script for end-of-session saves

## Decisions Made

- Public/private split: shared config public, personal profile private
- Fine-grained PAT scoped to `claude-config` only
- GitHub remote MCP (`api.githubcopilot.com/mcp`) over local Docker — simpler, no container management
- Daily conversation saves via simple script + manual push (budget-friendly, no cron/automation overhead)

## Key Commands

```bash
# Profile switching
./scripts/switch-profile.sh izza

# Sync to GitHub
./scripts/sync.sh "commit message"

# Save a conversation
./scripts/save-conversation.sh "Session Title" "summary text"

# GitHub MCP in Claude Code
claude mcp add --transport http github \
  https://api.githubcopilot.com/mcp \
  --header "Authorization: Bearer $GITHUB_PAT" \
  --scope user
```

## Corrections

- Ava is 9, Laila is 11 (not the other way around) — fixed in memory
