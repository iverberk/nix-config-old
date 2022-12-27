local map = require('utils').map

map('n', 's', ':Pounce<cr>')
map('n', 'S', ':PounceRepeat<cr>')
map('v', 's', ':Pounce<cr>')

require('pounce').setup({
  accept_keys = "JFKDLSAHGNUVRBYTMICEOXWPQZ",
  accept_best_key = "<enter>",
  multi_window = true,
  debug = false,
})
