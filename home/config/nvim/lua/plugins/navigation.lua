local Util = require("util")

return {
  {
    'numtostr/Navigator.nvim',
    cmd = {
      'NavigatorLeft',
      'NavigatorRight',
      'NavigatorUp',
      'NavigatorDown',
    },
    opts = {
      auto_save = nil,
      disable_on_zoom = false,
      mux = 'auto'
    }
  },

  {
    'nvim-tree/nvim-tree.lua',
    cmd = "NvimTreeToggle",
    keys = {
      {
        "<leader>n",
        function()
          require("nvim-tree.api").tree.toggle({ path = require("util").get_root() })
        end,
        desc = "Toggle NvimTree explorer (root dir)",
      },
    },
    opts = {
      sync_root_with_cwd = true,
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
      },
      notify = {
        threshold = vim.log.levels.WARNING,
      },
    }
  },

  {
    'nvim-telescope/telescope.nvim',
    cmd =  'Telescope',
    keys = {
      { "<M-b>", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
      { "<M-g>", Util.telescope("live_grep"), desc = "Find in Files (Grep)" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<C-p>", Util.telescope("files"), desc = "Find Files (root dir)" },
      { "<M-p>", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
      { "<M-o>", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      { "<M-*>", Util.telescope("grep_string"), desc = "Word (root dir)" },
    },
    opts = function()
      local actions = require('telescope.actions')

      return {
        defaults = {
          file_ignore_patterns = { "node_modules/.*", "vendor/.*" },
          prompt_prefix = " ",
          selection_caret = " ",
          mappings = {
            i = {
              ["<esc>"] = actions.close,
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
              ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
              ['<c-d>'] = "delete_buffer",
            }
          },
        },
      }
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("persisted") 
    end,
  },

  {
    'olimorris/persisted.nvim',
    opts = {
      save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"),
      allowed_dirs = { "~/code" },
      use_git_branch = false,
      command = 'VimLeavePre',
      telescope = {
        before_source = function()
          vim.api.nvim_input("<Esc><Cmd>SessionSave<CR>")
          vim.api.nvim_input("<Cmd>bufdo Bdelete<CR>")
        end,
        after_source = function(session)
          local message = "Autoloaded session"
          if session then
            message = "Loaded session " .. session.name
          end

          vim.defer_fn(function()
            vim.notify(message, vim.log.levels.INFO, { title = "Session manager" })
          end, 0)
        end
      },
    },
    keys = {
      { "<M-s>", "<cmd>Telescope persisted<cr>", desc = "Open session picker" },
    }
  },

  {
    'rlane/pounce.nvim',
    cmd = 'Pounce',
    keys = {
      { "<leader>s", "<cmd>Pounce<cr>", desc = "Jump to search pattern" },
    },
    opts =  {
      accept_keys = "JFKDLSAHGNUVRBYTMICEOXWPQZ",
      accept_best_key = "<enter>",
      multi_window = true,
      debug = false,
    }
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
      triggers = {"<leader>"}
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register({
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["gz"] = { name = "+surround" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader><tab>"] = { name = "+tabs" },
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>f"] = { name = "+file/find" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>gh"] = { name = "+hunks" },
        ["<leader>q"] = { name = "+quit/session" },
        ["<leader>s"] = { name = "+search" },
        ["<leader>sn"] = { name = "+noice" },
        ["<leader>u"] = { name = "+ui" },
        ["<leader>w"] = { name = "+windows" },
        ["<leader>x"] = { name = "+diagnostics/quickfix" },
      })
    end,
  }
}
