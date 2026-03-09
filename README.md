# claude-config

Shared Claude configuration, memory, and conversation management.

> Ahmed's personal profile is kept in a separate private repo: [ahmed-masud/claude-personal](https://github.com/ahmed-masud/claude-personal)

## Structure

```
claude-config/
├── system/                  # Profiles & system config
│   ├── profiles/
│   │   ├── izza/            # Izza's profile
│   │   └── default          # → symlink to active profile
│   └── config.toml          # Repo-level configuration
├── memory/                  # Claude memory & Distilligent context
│   ├── README.md
│   └── context/             # Distilligent context snapshots
├── conversations/           # Conversation data
│   ├── active/
│   └── archive/
├── settings/                # Claude.ai exported settings
└── scripts/                 # Utility scripts
    ├── switch-profile.sh
    └── sync.sh
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
