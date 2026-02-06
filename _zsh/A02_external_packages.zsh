# [環境変数定義]
# brew packages
path=(/opt/homebrew/bin /opt/homebrew/sbin ${path})

if (( ${+commands[sheldon]} )); then
    eval "$(sheldon source)"
fi

if (( ${+commands[mise]} )); then
    eval "$(mise activate zsh)"
fi

if (( ${+commands[go]} )); then
    export GOPATH=${HOME}/go
    path=(${GOPATH}/bin(N-/) ${path})
fi

eval "$(git wt --init zsh)"
