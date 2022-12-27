return {
  { "nvim-lua/plenary.nvim", lazy = true },
  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "tpope/vim-repeat", event = "VeryLazy" },
  { 'direnv/direnv', lazy = false },
  {
    'nathom/filetype.nvim',
    lazy = false,
    priority = 999,
    opts = {
      overrides = {
        extensions = {
          tf = "terraform",
          tfvars = "terraform",
          tfstate = "json",
        },
      },
    }
  }
}
