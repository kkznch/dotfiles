# dotfiles

nix-darwin + home-manager で管理する macOS 設定ファイル群。

## セットアップ

### 新規マシンの場合

```bash
# 1. リポジトリをクローン
git clone https://github.com/kkznch/dotfiles.git ~/ghq/github.com/kkznch/dotfiles
cd ~/ghq/github.com/kkznch/dotfiles

# 2. ブートストラップ実行
./bootstrap.sh
```

### 設定変更時

```bash
./bootstrap.sh
```

## 構成

```
.
├── flake.nix              # エントリポイント
├── flake.lock             # 依存関係ロック
├── bootstrap.sh           # 初回セットアップ
│
├── modules/
│   ├── darwin/            # macOSシステム設定
│   │   ├── default.nix
│   │   ├── homebrew.nix   # Homebrewパッケージ (GUI アプリ, git-wt)
│   │   └── system.nix     # Dock, Finder等
│   │
│   └── home/              # ユーザー設定
│       ├── default.nix
│       ├── links.nix      # シンボリックリンク
│       └── packages.nix   # CLIパッケージ (Nix管理)
│
├── files/                 # リンク・参照されるファイル群
│   ├── config/            # → ~/.config/*
│   │   ├── alacritty/
│   │   ├── emacs/
│   │   ├── git/
│   │   ├── karabiner/
│   │   ├── sheldon/
│   │   ├── vscode/
│   │   ├── zellij/
│   │   └── zsh/
│   ├── zshrc              # → ~/.zshrc
│   ├── editorconfig       # → ~/.editorconfig
│   └── Brewfile.vscode    # VSCode拡張リスト
│
└── docs/
    └── nix-guide.md       # Nix解説
```

## よく使うコマンド

```bash
# 設定適用
./bootstrap.sh

# パッケージ更新 (flake.lock の nixpkgs を最新に)
nix flake update

# ゴミ掃除
nix-collect-garbage -d
```

## パッケージ追加

### CLI ツール (Nix)

`modules/home/packages.nix` に追加：

```nix
home.packages = with pkgs; [
  新しいツール
];
```

パッケージ検索: `nix search nixpkgs <名前>`

### GUI アプリ (Homebrew)

`modules/darwin/homebrew.nix` の `casks` に追加：

```nix
casks = [
  "新しいアプリ"
];
```

### dotfile

`modules/home/links.nix` に追加：

```nix
xdg.configFile = {
  "新しい設定".source = mkOutOfStoreSymlink "${filesDir}/config/新しい設定";
};
```

## 詳細

[docs/nix-guide.md](docs/nix-guide.md) を参照。
