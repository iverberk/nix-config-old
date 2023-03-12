local path = require('lspconfig/util').path

local function get_python_path(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
  end

  -- Find and use virtualenv in workspace directory.
  for _, pattern in ipairs({ '*', '.*' }) do
    local match = vim.fn.glob(path.join(workspace, pattern, 'pyvenv.cfg'))
    if match ~= '' then
      return path.join(path.dirname(match), 'bin', 'python')
    end
  end

  -- Fallback to system Python.
  return exepath('python3') or exepath('python') or 'python'
end

return {
  bashls = {},
  tsserver = {},
  tflint = {},
  jsonls = {
    cmd = { "vscode-json-languageserver", "--stdio" },
    settings = {
      json = {
        -- schemas = require('schemastore').json.schemas(),
        validate = { enable = true },
      },
    },
    setup = {
      commands = {
        Format = {
          function()
            vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line('$'), 0 })
          end,
        },
      },
    },
  },
  gopls = {
    settings = {
      analyses = {
        unusedparams = false
      },
      staticcheck = true
    }
  },
  pyright = {
    settings = {
      python = {
        analysis = {
          typeCheckingMode = 'off',
          useLibraryCodeForTypes = true,
          completeFunctionParens = true,
        },
      },
    },
    before_init = function(_, config)
      config.settings.python.pythonPath = get_python_path(config.root_dir)
    end,
  },
  yamlls = {},
  terraformls = {},
}
