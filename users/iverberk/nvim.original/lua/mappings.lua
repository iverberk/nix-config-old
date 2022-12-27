local map = require ('utils').map

map('v', '<leader>y', '"+y')
map('n', '<leader>p', '"+p')
map('n', '<leader>w', ':w<cr>')
map('n', '<leader>q', ':q<cr>')
map('n', '<leader>/', ':nohlsearch<cr>')
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')
map('n', 'j', 'gj')
map('n', 'k', 'gk')
map('n', 'gj', 'j')
map('n', 'gk', 'k')
map('i', 'jj', '<Esc>')
map('i', 'jk', '<Esc>')
