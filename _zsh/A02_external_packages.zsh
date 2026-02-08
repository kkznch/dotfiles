# [環境変数定義]
# brew packages
path=(/opt/homebrew/bin /opt/homebrew/sbin ${path})

if (( ${+commands[sheldon]} )); then
    eval "$(sheldon source)"
fi

if (( ${+commands[mise]} )); then
    eval "$(mise activate zsh)"
fi

# go (go install)
path=(${HOME}/go/bin(N-/) ${path})

# rust (cargo install)
path=(${HOME}/.cargo/bin(N-/) ${path})

eval "$(git wt --init zsh)"
