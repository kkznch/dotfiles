-- 基本モジュールの読み込み
require("options")  -- 基本設定
require("keymaps")  -- キーマップ

-- lazy.nvim (モダンなプラグイン管理)のセットアップ
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- 安定版を使用
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- プラグインの読み込み
require("lazy").setup("plugins") 