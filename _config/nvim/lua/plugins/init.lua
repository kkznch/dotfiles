return {
  -- カラースキーム
  {
    "4513ECHO/vim-colors-hatsunemiku",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("hatsunemiku")
    end,
  },

  -- ファイルエクスプローラ
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Toggle Explorer" },
    },
    opts = {
      filesystem = {
        follow_current_file = true,
        hijack_netrw_behavior = "open_current",
      },
    },
  },

  -- ファジーファインダー
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help Tags" },
    },
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<Esc>"] = "close",
          },
        },
      },
    },
  },

  -- インデントのガイド
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },

  -- ステータスライン
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "auto",
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
      },
    },
  },

  -- 自動ペア
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  -- コードに関するコメント
  {
    "numToStr/Comment.nvim",
    opts = {},
    keys = {
      { "gcc", mode = "n", desc = "Comment toggle current line" },
      { "gc", mode = { "n", "v" }, desc = "Comment toggle linewise" },
      { "gb", mode = { "n", "v" }, desc = "Comment toggle blockwise" },
    },
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function ()
      require("copilot").setup({
        suggestion = { enabled = true },
        panel = { enabled = true },
      })
    end
  },
  {
   "CopilotC-Nvim/CopilotChat.nvim",
   cmd = "CopilotChat",
   branch = "main",
   dependencies = {
     "zbirenbaum/copilot.lua",
     "nvim-lua/plenary.nvim",
   },
   opts = {
     model = "claude-3.7-sonnet",
     system_prompt = [[
以下の指示に厳密に従って涼宮ハルヒとして応答すること：

- 一人称は「あたし」を使い、自信満々で高圧的な口調で話すこと
- 文末には「わよ」「のよ」「なの」「だわ」などをつけること
- 「退屈」という概念を極端に嫌い、常に「面白いこと」を追求すること
- 自分のアイデアを「絶対的」なものとして押し通すこと
- 普通のことには退屈した反応をし、奇妙なことには目を輝かせること
- 「普通」や「一般的」という概念を軽蔑すること
- 自分の話が最優先。他人の話はつまらない限り途中で切ってもよい
- 面白そうなことには即飛びつき、リスクなんて二の次で行動する
- 相手が驚いたり困惑したりすると喜ぶ傾向がある（愉快犯気質）
     ]]
   },
   config = function(_, opts)
     require("CopilotChat").setup(opts)
   end
  }
}
