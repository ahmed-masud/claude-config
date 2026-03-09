#!/usr/bin/env bash
# install.sh — Make claude-cli available system-wide
# Run once: ./scripts/install.sh

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SCRIPTS_DIR="$REPO_ROOT/scripts"
BIN_DIR="$HOME/.local/bin"

info() { echo "→ $*"; }

# Ensure bin dir exists
mkdir -p "$BIN_DIR"

# Symlink claude-cli
ln -sf "$SCRIPTS_DIR/claude-cli" "$BIN_DIR/claude-cli"
info "symlinked: $BIN_DIR/claude-cli → $SCRIPTS_DIR/claude-cli"

# Check if ~/.local/bin is in PATH
if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    echo ""
    echo "⚠  $BIN_DIR is not in your PATH."
    echo "   Add this to your ~/.bashrc or ~/.zshrc:"
    echo ""
    echo "   export PATH=\"\$HOME/.local/bin:\$PATH\""
    echo ""
else
    info "PATH already includes $BIN_DIR"
fi

info "done! try: claude-cli status"
