return {
  {
    'stevearc/overseer.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    cmd = "OverseerRun",
    keys = {
      { "<leader>rt", "<cmd>OverseerRun<cr>", desc = "Run a task" },
      { "<leader>rl", "<cmd>OverseerRestartLast<cr>", desc = "Restart last task" },
      { "<leader>tt", "<cmd>OverseerToggle<cr>", desc = "Open task list" },
    },
    opts = {
      templates = { "builtin", "terraform" },
      task_list = {
        bindings = {
          ["?"] = "ShowHelp",
          ["<CR>"] = "RunAction",
          ["<C-e>"] = "Edit",
          ["o"] = "Open",
          ["<C-v>"] = "OpenVsplit",
          ["<C-s>"] = "OpenSplit",
          ["<C-f>"] = "OpenFloat",
          ["<C-q>"] = "OpenQuickFix",
          ["p"] = "TogglePreview",
          ["<M-l>"] = "IncreaseDetail",
          ["<M-h>"] = "DecreaseDetail",
          ["L"] = "IncreaseAllDetail",
          ["H"] = "DecreaseAllDetail",
          ["["] = "DecreaseWidth",
          ["]"] = "IncreaseWidth",
          ["{"] = "PrevTask",
          ["}"] = "NextTask",
        },
      }
    },
    config = function(_, opts)
      require("overseer").setup(opts)

      vim.api.nvim_create_user_command("OverseerRestartLast", function()
        local overseer = require("overseer")
        local tasks = overseer.list_tasks({ recent_first = true })
        if vim.tbl_isempty(tasks) then
          vim.notify("No tasks found", vim.log.levels.WARN)
        else
          overseer.run_action(tasks[1], "restart")
        end
      end, {})
    end,
  }
}
