# claude

Personal Claude configuration, memory, and conversation management.

## Structure

```
claude/
├── system/          # Profiles & system config
│   ├── profiles/    # Per-user Claude preference profiles
│   │   ├── ahmed/   # Ahmed's profile
│   │   ├── izza/    # Izza's profile
│   │   └── default  # → symlink to active profile
│   └── config.toml  # Repo-level configuration
├── memory/          # Claude memory edits & Distilligent context
│   ├── edits.md     # Claude memory system edits
│   └── context/     # Distilligent context snapshots
├── conversations/   # Conversation data
│   ├── active/      # Current/ongoing conversations
│   └── archive/     # Completed conversations
├── settings/        # Claude.ai exported settings
└── scripts/         # Utility scripts
```

## Profile Switching

```bash
# Switch to a different profile
./scripts/switch-profile.sh izza

# Check active profile
ls -la system/profiles/default
```

## Quick Sync

```bash
# Snapshot current state and push
./scripts/sync.sh "updated memory edits"

# Pull latest
./scripts/sync.sh --pull
```

## Profiles

Each profile under `system/profiles/<name>/` contains:
- `preferences.md` — The Claude userPreferences document
- `memory-edits.md` — Memory edits specific to that profile
- `context.md` — Additional context notes

The `default` symlink determines which profile is active.
