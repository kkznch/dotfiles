# 基本コマンド
alias rm="rm -i"
alias cp="cp -i"
case "${OSTYPE}" in
freebsd* | darwin*)
    alias ls="ls -G -w"
    ;;
linux*)
    alias ls="ls --color"
    ;;
esac
alias repos="ghq list -p | sk"
alias repo='cd $(repos)'
alias gh-repos="gh repo list -L 1000 --json sshUrl -q '.[].sshUrl' | sk | pbcopy"
alias fzf="find . -not -path '.git' -not -path 'node_modules' | sk"

curlw() {
    curl -s -o /dev/null -w '{"meta":{"http_code":"%{http_code}","time_total":"%{time_total}","time_namelookup":"%{time_namelookup}","time_connect":"%{time_connect}","time_redirect":"%{time_redirect}","size_download":"%{size_download}","size_request":"%{size_request}","speed_download":"%{speed_download}","content_type":"%{content_type}","num_connects":"%{num_connects}","num_redirects":"%{num_redirects}","redirect_url":"%{redirect_url}"}}' ${1}
}

history-selection() {
    BUFFER=$(history -n 1 | tail -r | awk '!a[$0]++' | sk)
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N history-selection
bindkey '^R' history-selection
