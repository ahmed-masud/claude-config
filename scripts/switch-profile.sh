#!/usr/bin/env bash
# switch-profile.sh — Switch the active Claude profile
# Usage: ./scripts/switch-profile.sh <profile-name>

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PROFILES_DIR="$REPO_ROOT/system/profiles"
LINK="$PROFILES_DIR/default"

# --- helpers ---
die()  { echo "error: $*" >&2; exit 1; }
info() { echo "→ $*"; }

# --- list available profiles ---
list_profiles() {
    echo "Available profiles:"
    for d in "$PROFILES_DIR"/*/; do
        name="$(basename "$d")"
        [[ "$name" == "default" ]] && continue
        if [[ -L "$LINK" && "$(readlink "$LINK")" == "$name" ]]; then
            echo "  * $name  (active)"
        else
            echo "    $name"
        fi
    done
}

# --- main ---
if [[ $# -eq 0 ]]; then
    list_profiles
    exit 0
fi

PROFILE="$1"
PROFILE_DIR="$PROFILES_DIR/$PROFILE"

[[ -d "$PROFILE_DIR" ]] || die "profile '$PROFILE' not found. Run without args to list."

# Check if already active
if [[ -L "$LINK" && "$(readlink "$LINK")" == "$PROFILE" ]]; then
    info "already on profile '$PROFILE'"
    exit 0
fi

# Switch
cd "$PROFILES_DIR"
rm -f default
ln -s "$PROFILE" default

info "switched to profile: $PROFILE"

# Auto-commit if configured
if grep -q 'auto_commit = true' "$REPO_ROOT/system/config.toml" 2>/dev/null; then
    cd "$REPO_ROOT"
    if git rev-parse --git-dir >/dev/null 2>&1; then
        git add -A
        git commit -m "profile: switched to $PROFILE [$(date -u +%Y-%m-%dT%H:%M:%SZ)]" --quiet
        info "auto-committed"
    fi
fi
