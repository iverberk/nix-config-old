local sm = require('session_manager')

sm.setup({
  autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
  autosave_ignore_filetypes = {
    'gitcommit',
    'neo-tree',
  },
  autosave_only_in_session = true
})
