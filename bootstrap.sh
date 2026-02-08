#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR"

echo "=== dotfiles bootstrap ==="
echo "Dotfiles directory: $DOTFILES_DIR"

# 1. Install Nix if not present
if ! command -v nix &> /dev/null; then
    echo "Nix is not installed. Installing..."
    curl -L https://nixos.org/nix/install | sh -s -- --daemon
    echo "Please restart your shell and run this script again."
    exit 0
fi

# 2. Enable flakes (create config if needed)
mkdir -p ~/.config/nix
if [ ! -f ~/.config/nix/nix.conf ]; then
    echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
fi

# 3. Backup existing shell configs if needed
if [ -f /etc/bashrc ] && [ ! -f /etc/bashrc.before-nix-darwin ]; then
    echo "Backing up /etc/bashrc..."
    sudo mv /etc/bashrc /etc/bashrc.before-nix-darwin
fi
if [ -f /etc/zshrc ] && [ ! -f /etc/zshrc.before-nix-darwin ]; then
    echo "Backing up /etc/zshrc..."
    sudo mv /etc/zshrc /etc/zshrc.before-nix-darwin
fi

# 4. Get hostname
HOSTNAME=$(hostname -s)
echo "Host: $HOSTNAME"

# 5. Run nix-darwin
echo "Running darwin-rebuild switch..."
if command -v darwin-rebuild &> /dev/null; then
    # Already have nix-darwin installed (requires sudo for system activation)
    sudo darwin-rebuild switch --flake "$DOTFILES_DIR#$HOSTNAME" --impure
else
    # First time: bootstrap nix-darwin
    sudo nix run nix-darwin -- switch --flake "$DOTFILES_DIR#$HOSTNAME"
fi

# 6. Install VS Code extensions (if VS Code is installed)
if command -v code &> /dev/null; then
    echo "Installing VS Code extensions..."
    brew bundle --file="$DOTFILES_DIR/files/Brewfile.vscode"
fi

echo "=== Done! ==="
