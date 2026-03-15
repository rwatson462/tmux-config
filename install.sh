#!/usr/bin/env bash
# Terminal Workspace - Installation script
# Installs dependencies and sets up global access

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_DIR="${HOME}/.local/bin"

echo "Terminal Workspace Installer"
echo "============================"
echo ""

# Check for Homebrew
if ! command -v brew &>/dev/null; then
    echo "Error: Homebrew is required but not installed."
    echo "Install it from: https://brew.sh"
    exit 1
fi

# Install dependencies
echo "Checking dependencies..."

install_if_missing() {
    local pkg="$1"
    if ! command -v "$pkg" &>/dev/null; then
        echo "  Installing $pkg..."
        brew install "$pkg"
    else
        echo "  $pkg: already installed"
    fi
}

install_if_missing tmux
install_if_missing fzf
install_if_missing yq

echo ""

# Create install directory if needed
mkdir -p "$INSTALL_DIR"

# Create symlink for global access
WORKSPACE_LINK="$INSTALL_DIR/workspace"

if [[ -L "$WORKSPACE_LINK" ]]; then
    echo "Updating existing symlink..."
    rm "$WORKSPACE_LINK"
elif [[ -e "$WORKSPACE_LINK" ]]; then
    echo "Warning: $WORKSPACE_LINK already exists and is not a symlink."
    echo "Please remove it manually and run this script again."
    exit 1
fi

ln -s "$SCRIPT_DIR/bin/workspace" "$WORKSPACE_LINK"
echo "Created symlink: $WORKSPACE_LINK -> $SCRIPT_DIR/bin/workspace"

echo ""

# Check if install dir is in PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo "Note: $INSTALL_DIR is not in your PATH."
    echo ""
    echo "Add it by adding this line to your shell config (~/.zshrc or ~/.bashrc):"
    echo ""
    echo "    export PATH=\"\$HOME/.local/bin:\$PATH\""
    echo ""
fi

echo "Installation complete!"
echo ""
echo "Usage:"
echo "  workspace    # Start the terminal workspace"
echo ""
echo "Configure your projects in:"
echo "  $SCRIPT_DIR/config/projects.yml"
