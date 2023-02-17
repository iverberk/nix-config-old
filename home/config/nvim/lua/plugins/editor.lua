return {
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },

  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      hooks = {
        pre = function()
          require("ts_context_commentstring.internal").update_commentstring({})
        end,
      },
    },
    config = function(_, opts)
      require("mini.comment").setup(opts)
    end,
  },

  { 'tpope/vim-surround', event = 'VeryLazy' },

  {
    'rlane/pounce.nvim',
    cmd = 'Pounce',
    keys = {
      { "<leader>s", "<cmd>Pounce<cr>", desc = "Jump to search pattern" },
    },
    opts =  {
      accept_keys = "JFKDLSAHGNUVRBYTMICEOXWPQZ",
      accept_best_key = "<enter>",
      multi_window = true,
      debug = false,
    }
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    keys = {
      { "<c-space>", desc = "Increment selection" },
      { "<bs>", desc = "Schrink selection", mode = "x" },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      context_commentstring = { enable = true, enable_autocmd = false },
      ensure_installed = {
        "bash",
        "help",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = "<nop>",
          node_decremental = "<bs>",
        },
      },
    },
    config = function(plugin, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    'famiu/bufdelete.nvim',
    cmd = { 'Bdelete', 'Bwipeout' }
  },

  {
    'sindrets/diffview.nvim',
    cmd = {'DiffviewOpen', 'DiffviewFileHistory' },
    opts = {}
  },

  {
    'akinsho/toggleterm.nvim',
    event = 'VeryLazy',
    config = function()

      require('toggleterm').setup({})

      function _lazygit_toggle()
        local count = 0

        for char in string.gmatch(vim.api.nvim_eval("sha256(getcwd())"), '%S') do
          count = count + string.byte(char)
        end

        local term = require('toggleterm.terminal').Terminal:new({
          count = count,
          cmd = "lazygit",
          dir = "git_dir",
          autochdir = true,
          direction = "float",
          close_on_exit = true,
          float_opts = {
            border = "double",
            width = function()
              return math.floor(vim.o.columns)
            end,

            height = function()
              return math.floor((vim.o.lines - vim.o.cmdheight))
            end,
          }
        })

        term:toggle()
      end
    end
  }

}
