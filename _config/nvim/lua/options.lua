local opt = vim.opt

-- UI設定
opt.number = true         -- 行番号表示
opt.relativenumber = true -- 相対行番号表示（超便利！）
opt.cursorline = true     -- カーソル行をハイライト
opt.signcolumn = "yes"    -- サインカラムを常に表示
opt.showmode = false      -- モード表示はステータスラインに任せる
opt.termguicolors = true  -- True Colorサポート
opt.scrolloff = 8         -- スクロール時の視界確保

-- 検索設定
opt.ignorecase = true     -- 大文字小文字を区別しない検索
opt.smartcase = true      -- 検索パターンに大文字が含まれる場合は区別する

-- エディタ設定
opt.expandtab = true      -- タブをスペースに
opt.shiftwidth = 2        -- インデントのスペース数
opt.tabstop = 2           -- タブのスペース数
opt.smartindent = true    -- スマートインデント

-- ファイル設定
opt.swapfile = false      -- スワップファイルなし
opt.backup = false        -- バックアップなし
opt.undofile = true       -- 永続的アンドゥ

-- その他
opt.clipboard = "unnamedplus"  -- システムクリップボードと連携
opt.mouse = "a"           -- マウスサポート有効

-- グローバル設定
vim.g.mapleader = " "     -- リーダーキーをスペースに

-- シンタックスハイライト
vim.cmd('syntax enable') 