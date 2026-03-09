#!/usr/bin/env bash
# save-conversation.sh — Save a conversation summary to the repo
# Usage: ./scripts/save-conversation.sh "title" < summary.md
#   or:  ./scripts/save-conversation.sh "title" "one-line summary"
#
# Designed to be called by Claude Code at the end of a session.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONVOS_DIR="$REPO_ROOT/conversations/active"
TODAY="$(date -u +%Y-%m-%d)"
TIMESTAMP="$(date -u +%Y-%m-%dT%H:%M:%SZ)"

die()  { echo "error: $*" >&2; exit 1; }
info() { echo "→ $*"; }

[[ $# -ge 1 ]] || die "usage: save-conversation.sh \"title\" [\"summary\"]"

TITLE="$1"
# Slugify the title for filename
SLUG="$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd 'a-z0-9-')"
FILENAME="${TODAY}-${SLUG}.md"
FILEPATH="$CONVOS_DIR/$FILENAME"

# If second arg given, use it as body. Otherwise read from stdin.
if [[ $# -ge 2 ]]; then
    BODY="$2"
else
    BODY="$(cat)"
fi

cat > "$FILEPATH" <<EOF
# ${TITLE}

- **Date:** ${TODAY}
- **Saved:** ${TIMESTAMP}
- **Source:** $([ -n "${CLAUDE_SOURCE:-}" ] && echo "$CLAUDE_SOURCE" || echo "manual")

---

${BODY}
EOF

info "saved: $FILEPATH"

# Auto-commit and push if in a git repo
cd "$REPO_ROOT"
if git rev-parse --git-dir >/dev/null 2>&1; then
    git add "$FILEPATH"
    git commit -m "convo: ${TITLE} [${TODAY}]" --quiet
    if git remote get-url origin >/dev/null 2>&1; then
        git push --quiet && info "pushed" || info "push failed (offline?)"
    fi
fi
