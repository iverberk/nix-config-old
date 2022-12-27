return {
  { 'numtostr/comment.nvim', event = "VeryLazy" },
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
  }

}
