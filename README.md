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
darwin-rebuild switch --flake .
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
│   │   ├── homebrew.nix   # Homebrewパッケージ
│   │   └── system.nix     # Dock, Finder等
│   │
│   └── home/              # ユーザー設定
│       ├── default.nix
│       ├── links.nix      # シンボリックリンク
│       └── packages.nix   # ユーザーパッケージ
│
├── _zsh/                  # zsh設定
├── _zshrc
├── _config/               # アプリ設定
│   ├── git/
│   ├── alacritty/
│   ├── nvim/
│   └── ...
│
└── docs/
    └── nix-guide.md       # Nix解説
```

## よく使うコマンド

```bash
# 設定適用
darwin-rebuild switch --flake .

# 依存関係更新
nix flake update

# ゴミ掃除
nix-collect-garbage -d
```

## パッケージ追加

### CLI ツール

`modules/darwin/homebrew.nix` の `brews` に追加：

```nix
brews = [
  "新しいツール"
];
```

### GUI アプリ

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
  "新しい設定".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/_config/新しい設定";
};
```

## 詳細

[docs/nix-guide.md](docs/nix-guide.md) を参照。
