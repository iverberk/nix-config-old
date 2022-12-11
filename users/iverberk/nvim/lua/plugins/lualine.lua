local lualine = require('lualine')

lualine.setup({
  options = {
    theme = 'base16',
  },
  extensions = { 'neo-tree' },
  sections = {
    lualine_x = {
      'overseer'
    },
    lualine_y = {
      'filetype'
    },
    lualine_z = {
      'encoding'
    }
  }
})
