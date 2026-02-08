local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- スペースキーをリーダーに
vim.g.mapleader = " "

-- ノーマルモード
-- ウィンドウ操作
keymap("n", "<leader>w", "<cmd>w<CR>", opts)            -- 保存
keymap("n", "<leader>q", "<cmd>q<CR>", opts)            -- 終了
keymap("n", "<leader>h", "<C-w>h", opts)                -- 左のウィンドウへ
keymap("n", "<leader>j", "<C-w>j", opts)                -- 下のウィンドウへ
keymap("n", "<leader>k", "<C-w>k", opts)                -- 上のウィンドウへ
keymap("n", "<leader>l", "<C-w>l", opts)                -- 右のウィンドウへ

-- バッファ操作
keymap("n", "<S-l>", "<cmd>bnext<CR>", opts)            -- 次のバッファへ
keymap("n", "<S-h>", "<cmd>bprevious<CR>", opts)        -- 前のバッファへ
keymap("n", "<leader>c", "<cmd>bd<CR>", opts)           -- バッファを閉じる

-- 便利なショートカット
keymap("n", "<leader>e", "<cmd>Explore<CR>", opts)      -- ファイルエクスプローラー
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", opts)       -- ハイライト解除

-- 行移動
keymap("n", "<A-j>", "<cmd>m .+1<CR>==", opts)          -- 行を下に移動
keymap("n", "<A-k>", "<cmd>m .-2<CR>==", opts)          -- 行を上に移動

-- インサートモード
keymap("i", "jk", "<ESC>", opts)                        -- jkでEscキー
keymap("i", "kj", "<ESC>", opts)                        -- kjでEscキー

-- ビジュアルモード
-- インデント調整後も選択状態を維持
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- 行移動
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)          -- 選択行を下に移動
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)          -- 選択行を上に移動

-- ターミナルモード
keymap("t", "<Esc>", "<C-\\><C-n>", opts)              -- Escでターミナルモード終了 