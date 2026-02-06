# zshrc設定参考URL ---------------------------------------------------------------

# - [.zshrcの設定例（設定内容の説明コメント付き）](https://qiita.com/d-dai/items/d7f329b7d82e2165dab3)
# - [少し凝ったzshrc](https://gist.github.com/mollifier/4979906)

# システム -----------------------------------------------------------------------

# sudo用のpathを設定（環境変数SUDO_PATHと紐付け、重複排除）
typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=({/usr/local,/usr,}/sbin(N-/))

# pathを設定
path=(${HOME}/bin(N-/) /usr/local/{bin,sbin}(N-/) ${path})
typeset -U path cdpath fpath manpath

# 日本語を使用
export LANG=ja_JP.UTF-8

# 色を使用
autoload -Uz colors
colors

# 補完
autoload -U compinit
compinit

# デフォルトのエディタ
export EDITOR="vim"

# emacsキーバインドを使用
bindkey -e

# ビープ音を無効化
setopt no_beep
setopt nolistbeep

# cd省略してディレクトリ名のみで移動可能にする
setopt auto_cd

# 自動でpushdを実行
setopt auto_pushd

# pushdから重複を排除
setopt pushd_ignore_dups

# zmvコマンドを使用可能にする
autoload -Uz zmv

# backspace,deleteキーを使用可能にする
stty erase ^H
bindkey "^[[3~" delete-char

# どこからでも参照できるディレクトリパス
#cdpath=(~)

# 区切り文字の設定
autoload -Uz select-word-style
select-word-style default
zstyle ":zle:*" word-chars "_-./;@"
zstyle ":zle:*" word-style unspecified

# Ctrl+sのロック、Ctrl+qのロック解除を無効化
setopt no_flow_control

# 補完後、メニュー選択モードになり左右キーで移動ができる
zstyle ":completion:*:default*" menu select=2

# 補完で大文字にもマッチ
zstyle ":completion:*" matcher-list "m:{a-z}={A-Z}"

# History ------------------------------------------------------------------------
# 履歴格納ファイル
HISTFILE=~/.zsh_history
HISTSIZE=65536
SAVEHIST=65536

# 他のターミナルと履歴を共有
setopt share_history

# 履歴に重複を表示しない
setopt hist_ignore_all_dups

# ヒストリを呼び出してから実行する間に一旦編集可能
setopt hist_verify

# 余分な空白は詰めて記録
setopt hist_reduce_blanks

# コマンドを途中まで入力後、履歴から絞込
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# 補完候補を詰めて表示する
setopt list_packed
export LISTMAX=10000

# 表示 ---------------------------------------------------------------------------

# lsコマンドの色設定
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad
export LS_COLORS='di=36:ln=35:so=32:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

setopt PROMPT_SUBST

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'
