local nt = require('nvim-tree')

nt.setup({
  renderer = {
    special_files = {},
    icons = {
      show = {
        file = false,
        folder = false,
        git = false,
      }
    }
  },
  update_focused_file = {
    enable = true
  }
})
