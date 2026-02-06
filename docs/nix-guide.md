# Nix + nix-darwin + home-manager 解説

## 概要

このdotfilesは以下の3つのツールで構成されている：

| ツール | 役割 |
|--------|------|
| **Nix** | パッケージマネージャ本体 |
| **nix-darwin** | macOSのシステム設定を宣言的に管理 |
| **home-manager** | ユーザーのdotfiles/設定を宣言的に管理 |

## ディレクトリ構成

```
dotfiles/
├── flake.nix              # エントリポイント（依存関係定義）
├── flake.lock             # 依存関係のバージョンロック
│
├── modules/
│   ├── darwin/            # nix-darwin設定
│   │   ├── default.nix    # メイン設定
│   │   ├── homebrew.nix   # Homebrewパッケージ管理
│   │   └── system.nix     # macOSシステム設定
│   │
│   └── home/              # home-manager設定
│       ├── default.nix    # メイン設定
│       ├── links.nix      # シンボリックリンク定義
│       └── packages.nix   # ユーザーレベルパッケージ
│
├── bootstrap.sh           # 初回セットアップ用
│
├── _zsh/                  # zsh設定ファイル（実体）
├── _zshrc                 # zshrc（実体）
├── _config/               # アプリ設定ファイル（実体）
└── ...
```

## 基本的な使い方

### 設定を変更したい場合

1. 該当する`.nix`ファイルを編集
2. 以下を実行：
   ```bash
   darwin-rebuild switch --flake .
   ```

### 新しいパッケージを追加したい場合

**Homebrewパッケージ（CLI）:**
```nix
# modules/darwin/homebrew.nix
brews = [
  "新しいパッケージ"
];
```

**Homebrewパッケージ（GUIアプリ）:**
```nix
# modules/darwin/homebrew.nix
casks = [
  "新しいアプリ"
];
```

**Mac App Store:**
```nix
# modules/darwin/homebrew.nix
masApps = {
  "アプリ名" = アプリID;
};
```

### 新しいdotfileを追加したい場合

```nix
# modules/home/links.nix

# ホームディレクトリ直下の場合
home.file = {
  ".新しいファイル".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/_新しいファイル";
};

# ~/.config/下の場合
xdg.configFile = {
  "新しいディレクトリ".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/_config/新しいディレクトリ";
};
```

## ファイルの役割

### flake.nix

```nix
{
  # 依存関係の定義
  inputs = {
    nixpkgs.url = "...";      # Nixパッケージコレクション
    nix-darwin.url = "...";   # macOS用モジュール
    home-manager.url = "..."; # ユーザー設定用モジュール
  };

  # 出力（ビルド対象）の定義
  outputs = { ... }: {
    darwinConfigurations."ホスト名" = ...;
  };
}
```

### modules/darwin/default.nix

```nix
{
  # システム設定
  system.primaryUser = "ユーザー名";  # 主要ユーザー
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  programs.zsh.enable = true;  # zshを有効化
}
```

### modules/darwin/homebrew.nix

```nix
{
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";  # 未定義パッケージを削除
    brews = [ ... ];   # CLIツール
    casks = [ ... ];   # GUIアプリ
    masApps = { ... }; # Mac App Store
  };
}
```

### modules/darwin/system.nix

```nix
{
  # macOSシステム設定（defaults write相当）
  system.defaults = {
    dock.autohide = true;
    finder.ShowPathbar = true;
    # ...
  };
}
```

### modules/home/links.nix

```nix
{
  # ~/.* へのリンク
  home.file = {
    ".zshrc".source = mkOutOfStoreSymlink ".../_zshrc";
  };

  # ~/.config/* へのリンク
  xdg.configFile = {
    "git".source = mkOutOfStoreSymlink ".../_config/git";
  };
}
```

## よく使うコマンド

```bash
# 設定を適用
darwin-rebuild switch --flake .

# 設定をビルドのみ（適用しない）
darwin-rebuild build --flake .

# ガベージコレクション（古いバージョンを削除）
nix-collect-garbage -d

# flakeの更新（依存関係を最新に）
nix flake update
```

## トラブルシューティング

### "Path ... is not tracked by Git"

```bash
git add <該当ファイル>
```
Nixはgitで追跡されているファイルのみを見る。

### 既存ファイルとの衝突

`home-manager.backupFileExtension = "backup"` が設定されているので、
既存ファイルは `.backup` 拡張子でバックアップされる。

### Homebrewパッケージが勝手に削除される

`cleanup = "uninstall"` の設定により、`.nix`に書かれていないパッケージは削除される。
必要なパッケージは`homebrew.nix`に追加すること。

## Nix言語の基礎

### 基本構文

```nix
# アトリビュートセット（オブジェクト的なもの）
{
  key = "value";
  nested.key = "value";  # nested = { key = "value"; } と同じ
}

# リスト
[ "item1" "item2" "item3" ]

# 関数
{ arg1, arg2, ... }: { ... }

# let式（ローカル変数）
let
  x = 1;
  y = 2;
in
  x + y  # => 3

# 文字列補間
"Hello ${name}"

# 複数行文字列
''
  複数行の
  文字列
''
```

### よく見るパターン

```nix
# モジュール定義
{ config, pkgs, ... }:
{
  # 設定
}

# with式（スコープに展開）
with pkgs; [ git vim curl ]
# ↓と同じ
[ pkgs.git pkgs.vim pkgs.curl ]

# inherit（同名のキーと値）
{ inherit username; }
# ↓と同じ
{ username = username; }
```

## 参考リンク

- [Nix公式マニュアル](https://nixos.org/manual/nix/stable/)
- [nix-darwin](https://github.com/LnL7/nix-darwin)
- [home-manager](https://github.com/nix-community/home-manager)
- [Nix言語チュートリアル](https://nixos.org/guides/nix-language.html)
