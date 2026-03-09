#!/usr/bin/env bash
# sync.sh — Snapshot and sync Claude settings to GitHub
# Usage:
#   ./scripts/sync.sh "commit message"    # commit & push
#   ./scripts/sync.sh --pull              # pull latest
#   ./scripts/sync.sh --status            # show status

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

TIMESTAMP="$(date -u +%Y-%m-%dT%H:%M:%SZ)"

die()  { echo "error: $*" >&2; exit 1; }
info() { echo "→ $*"; }

# --- ensure we're in a git repo ---
git rev-parse --git-dir >/dev/null 2>&1 || die "not a git repository"

case "${1:-}" in
    --pull)
        info "pulling latest..."
        git pull --rebase
        info "done"
        ;;
    --status)
        echo "=== Active Profile ==="
        profile="$(readlink system/profiles/default 2>/dev/null || echo 'none')"
        echo "  $profile"
        echo ""
        echo "=== Git Status ==="
        git status --short
        echo ""
        echo "=== Last 5 Commits ==="
        git log --oneline -5 2>/dev/null || echo "  (no commits yet)"
        ;;
    "")
        die "usage: sync.sh \"commit message\" | --pull | --status"
        ;;
    *)
        MSG="$1"
        info "staging all changes..."
        git add -A

        # Check if there's anything to commit
        if git diff --cached --quiet; then
            info "nothing to commit, working tree clean"
            exit 0
        fi

        info "committing: $MSG"
        git commit -m "$MSG [$TIMESTAMP]"

        info "pushing..."
        git push

        info "synced @ $TIMESTAMP"
        ;;
esac
