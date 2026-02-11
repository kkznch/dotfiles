# [PATH]
path=(/opt/homebrew/bin /opt/homebrew/sbin ${path})  # Homebrew
path=(${HOME}/go/bin(N-/) ${path})                   # go install
path=(${HOME}/.cargo/bin(N-/) ${path})                # cargo install

# [環境変数]
# nix packages can't find system terminfo by default (e.g. skim panics with alacritty)
export TERMINFO_DIRS="${HOME}/.terminfo:/usr/share/terminfo"

# [ツール初期化]
eval "$(sheldon source)"
eval "$(mise activate zsh)"
eval "$(git wt --init zsh)"
