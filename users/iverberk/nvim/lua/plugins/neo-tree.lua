local nt = require('neo-tree')

vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

nt.setup({
  close_if_last_window = true,
  popup_border_style = "rounded",
  filesystem = {
    filtered_items = {
      visible = false,
      hide_dotfiles = false,
      hide_gitignored = true,
      hide_hidden = false,
    },
    follow_current_file = true,
    group_empty_dirs = false,
    use_libuv_file_watcher = false
  }
})
