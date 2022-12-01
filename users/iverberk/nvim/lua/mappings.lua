local map = require ('utils').map
local opts = { silent = true }

map('', "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

map('n', '<leader>n', ':Neotree reveal toggle<cr>', opts)

map('n', '<C-p>', ':Telescope find_files hidden=true<cr>', opts)
map('n', '<M-g>', ':Telescope live_grep<cr>', opts)
map('n', '<M-o>', ':Telescope oldfiles<cr>', opts)
map('n', '<M-*>', ':Telescope grep_string<cr>', opts)
map('n', '<M-b>', ':Telescope buffers<cr>', opts)
map('n', '<M-r>', ':Telescope registers<cr>', opts)
map('n', '<M-p>', ':Telescope projects<cr>', opts)
map('n', '<M-q>', ':Telescope quickfix<cr>', opts)
map('n', '<M-w>', ':Telescope workspaces<cr>', opts)

map("n", "<C-g>", "<cmd>lua _lazygit_toggle()<CR>", opts)

map('n', 's', ':Pounce<cr>', opts)
map('n', 'S', ':PounceRepeat<cr>', opts)
map('v', 's', ':Pounce<cr>', opts)

map('v', '<leader>y', '"+y', opts)
map('n', '<leader>p', '"+p', opts)
map('n', '<leader>w', ':w<cr>', opts)
map('n', '<leader>q', ':q<cr>', opts)
map('n', '<leader>/', ':nohlsearch<cr>', opts)
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)
map('n', 'j', 'gj', opts)
map('n', 'k', 'gk', opts)
map('n', 'gj', 'j', opts)
map('n', 'gk', 'k', opts)
map('i', 'jj', '<Esc>', opts)
map('i', 'jk', '<Esc>', opts)
