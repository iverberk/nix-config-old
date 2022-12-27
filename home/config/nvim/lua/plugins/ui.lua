return {
  {
    'RRethy/nvim-base16',
    lazy = false,
    priority = 1000,
    config = function()
      cs = require('base16-colorscheme')
      cs.setup("tomorrow-night-eighties", {
          telescope = false
      })

      vim.cmd([[colorscheme base16-tomorrow-night-eighties]])

      local hi = cs.highlight

      -- Make the parentheses matching highlight less obtrusive
      hi.MatchParen  = { guifg = '#cccccc', guibg = '#2d2d2d', gui = 'bold', guisp = nil }

      -- Soften vertical split background
      hi.VertSplit = { guifg='#373b41' }

      -- Soften indentation guidelines
      hi.IndentBlanklineChar = { guifg='#444444', gui='nocombine' }

    end
  },

  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    opts = {
      indentLine_enabled = 1,
      buftype_exclude = { "terminal", "nofile" },
      filetype_exclude = {
        "gitcommit", "markdown", "help", "NvimTree", "git", "TelescopePrompt", "undotree", "OverseerForm", ""
      },
      char = "│",
      show_trailing_blankline_indent = false,
      show_current_context = false,
      show_first_indent_level = true,
    }
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = 'base16',
      },
      extensions = { 'nvim-tree' },
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
    }
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      signs = {
        add = { text = "▍" },
        change = { text = "▍" },
        delete = { text = "▸" },
        topdelete = { text = "▾" },
        changedelete = { text = "▍" },
        untracked = { text = "▍" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end
    }
  },

  {
    'akinsho/toggleterm.nvim',
    event = 'VeryLazy',
    config = function()

      require('toggleterm').setup({})

      function _lazygit_toggle()
        local count = 0

        for char in string.gmatch(vim.api.nvim_eval("sha256(getcwd())"), '%S') do
          count = count + string.byte(char)
        end

        local term = require('toggleterm.terminal').Terminal:new({
          count = count,
          cmd = "lazygit",
          dir = "git_dir",
          autochdir = true,
          direction = "float",
          close_on_exit = true,
          float_opts = {
            border = "double",
            width = function()
              return math.floor(vim.o.columns)
            end,

            height = function()
              return math.floor((vim.o.lines - vim.o.cmdheight))
            end,
          }
        })

        term:toggle()
      end
    end
  }
}
