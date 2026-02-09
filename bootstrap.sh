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

# 2. Install Homebrew if not present
if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# 3. Enable flakes (create config if needed)
mkdir -p ~/.config/nix
if [ ! -f ~/.config/nix/nix.conf ]; then
    echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
fi

# 4. Backup /etc shell configs that conflict with nix-darwin
for f in /etc/bashrc /etc/zshrc; do
    if [ -f "$f" ]; then
        echo "Backing up $f..."
        sudo mv -f "$f" "$f.before-nix-darwin"
    fi
done

# 5. Get hostname
HOSTNAME=$(hostname -s)
echo "Host: $HOSTNAME"

# 6. Run nix-darwin
echo "Running darwin-rebuild switch..."
if command -v darwin-rebuild &> /dev/null; then
    # Already have nix-darwin installed (requires sudo for system activation)
    sudo darwin-rebuild switch --flake "$DOTFILES_DIR#$HOSTNAME" --impure
else
    # First time: bootstrap nix-darwin
    sudo nix run nix-darwin -- switch --flake "$DOTFILES_DIR#$HOSTNAME"
fi

# 7. Install VS Code extensions (if VS Code is installed)
if command -v code &> /dev/null; then
    echo "Installing VS Code extensions..."
    brew bundle --file="$DOTFILES_DIR/files/Brewfile.vscode"
fi

echo "=== Done! ==="
