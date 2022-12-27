local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  bootstrap = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    -- "https://github.com/wbthomason/packer.nvim",
    "-b",
    "feat/lockfile",
    "https://github.com/EdenEast/packer.nvim", -- Packer with lockfile support. Remove once it lands in upstream.
    install_path,
  }
  print "Fresh Packer installation. Close and reopen Neovim to activate."
  vim.cmd [[packadd packer.nvim]]
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
  git = {
    clone_timeout = 300, -- Timeout, in seconds, for git clones
  },
  lockfile = {
    enable = true,
    regen_on_update = true,
  }
}

return packer.startup(function(use)

  -- Packer with lockfile support. Remove once it lands in upstream.
  use ({ 'EdenEast/packer.nvim', branch = 'feat/lockfile' })

  -- Basics
  use ({
      -- 'wbthomason/packer.nvim',
      -- 'lewis6991/impatient.nvim',
      'direnv/direnv.vim',
      'nathom/filetype.nvim', -- Don't load all filetype autocmds
      'nvim-lua/plenary.nvim',
      'tpope/vim-surround',
  })

  -- Navigation
  use { 'nvim-telescope/telescope.nvim', config = [[ require('plugins/telescope') ]], requires = { 'nvim-lua/plenary.nvim' } }
  use { 'rlane/pounce.nvim', config = [[ require('plugins/pounce') ]] }
  use { 'knubie/vim-kitty-navigator', run = 'cp ./*.py ~/.config/kitty/' }
      "nvim-lua/plenary.nvim",
  use { 'nvim-tree/nvim-tree.lua', config = [[ require('plugins/nvim-tree') ]], requires = {
      "kyazdani42/nvim-web-devicons",
    }
  }

  -- Session management
  use { 'Shatur/neovim-session-manager', config = [[ require('plugins/neovim-session-manager') ]], requires = { 'nvim-lua/plenary.nvim' } }

  -- Task runner
  use { 'stevearc/overseer.nvim', config = [[ require('plugins/overseer') ]], requires = { 'nvim-lua/plenary.nvim' } }

  -- UI
  use { 'rcarriga/nvim-notify' }
  use { 'nvim-telescope/telescope-ui-select.nvim', config = [[ require('plugins/telescope-ui-select') ]], requires = { 'nvim-telescope/telescope.nvim' } }
  use { 'lewis6991/gitsigns.nvim', config = [[ require('plugins/gitsigns') ]], requires = { 'nvim-lua/plenary.nvim' } }
  use { 'RRethy/nvim-base16', config = [[ require('plugins/nvim-base16') ]] }
  use { 'akinsho/toggleterm.nvim', config = [[ require('plugins/toggleterm') ]] }
  use { 'lukas-reineke/indent-blankline.nvim', config = [[ require('plugins/indent-blankline') ]] }
  use { 'nvim-lualine/lualine.nvim', config = [[ require('plugins/lualine') ]], after = { 'nvim-base16' }, requires = {
      'kyazdani42/nvim-web-devicons', opt = true
      }
  }

  -- Auto-complete
  use { 'L3MON4D3/LuaSnip', config = [[ require('luasnip') ]] }
  use { 'rafamadriz/friendly-snippets' }
  use { 'hrsh7th/nvim-cmp', config = [[ require('plugins/nvim-cmp') ]], requires = { 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'saadparwaiz1/cmp_luasnip' } }
  use { 'jose-elias-alvarez/null-ls.nvim', config = [[ require('lsp/null-ls') ]] }
  use { 'neovim/nvim-lspconfig', config = [[ require('lsp') ]] }

  -- Language support
  -- use { 'danymat/neogen', config = [[ require('plugins/neogen') ]], requires = "nvim-treesitter/nvim-treesitter", tag = "*" }
  use { 'nvim-treesitter/nvim-treesitter', config = [[ require('plugins/nvim-treesitter') ]], run = ':TSUpdate' }
  use { "windwp/nvim-autopairs", config = [[ require('plugins/nvim-autopairs') ]] }
  use { 'numtostr/comment.nvim', config = [[ require('plugins/comment') ]] }
  -- use { 'ray-x/go.nvim', config = [[ require('plugins/go') ]], requires = { 'ray-x/guihua.lua' } }
  -- use { 'JoosepAlviste/nvim-ts-context-commentstring', requires = "nvim-treesitter/nvim-treesitter" }
  -- use { 'windwp/nvim-ts-autotag', config = [[ require('plugins/nvim-ts-autotag') ]] }

  -- Debugging
  -- use { 'mfussenegger/nvim-dap', config = [[ require('plugins/nvim-dap') ]] }
  -- use { 'mfussenegger/nvim-dap-python', config = [[ require('plugins/nvim-dap-python') ]], after = { 'nvim-dap' } }
  -- use { 'nvim-telescope/telescope-dap.nvim', after = { 'nvim-dap' } }

  -- Testing
  -- use { 'nvim-neotest/neotest', config = [[ require('plugins/nvim-neotest') ]], requires = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter", "antoinemadec/FixCursorHold.nvim" } }
  -- use { 'nvim-neotest/neotest-python', requires = { 'nvim-neotest/neotest' } }

  if bootstrap then
    require("packer").sync()
  end

end)
