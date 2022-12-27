-- Set global options
require('options')

-- Initialize Lazy plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  defaults = { lazy = true },
  lockfile = "~/code/github.com/iverberk/nix-config/home/config/nvim/lazy-lock.json",
  checker = { enabled = false },
  install = { colorscheme = { "base16-tomorrow-night-eighties" } },
  ui = {
    border = "single",
  },
  performance = {
    cache = {
      enabled = true,
      -- disable_events = {},
    },
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
        "nvim-treesitter-textobjects",
      },
    },
  },
})

-- Load auto commands and keymaps
require("autocmds")
require("keymaps")
