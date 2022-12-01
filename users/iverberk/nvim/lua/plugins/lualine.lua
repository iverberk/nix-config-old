local lualine = require('lualine')

lualine.setup({
  options = {
    theme = 'base16',
  },
  extensions = { 'neo-tree' },
  sections = {
    lualine_x = {
      'encoding'
    }
  }
})
