local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

lspconfig.gopls.setup({
  analyses = {
    unusedparams = false
  },
  staticcheck = true
})

lspconfig.pyright.setup({
  settings = {
    python = {
      analysis = {
        useLibraryCodeForTypes = true,
        typeCheckingMode = "off"
      }
    }
  }
})

lspconfig.terraformls.setup({
  filetypes = { "tf", "terraform" }
})

local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = '✘'})
sign({name = 'DiagnosticSignWarn', text = '▲'})
sign({name = 'DiagnosticSignHint', text = '⚑'})
sign({name = 'DiagnosticSignInfo', text = ''})

vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  underline = false,
  float = {
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function()
    local buf_map = function(mode, lhs, rhs)
      local opts = {buffer = true}
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Displays hover information about the symbol under the cursor
    buf_map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

    -- Jump to the definition
    buf_map('n', 'gd', '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>')

    -- Jump to declaration
    buf_map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

    -- Lists all the implementations for the symbol under the cursor
    buf_map('n', 'gi', '<cmd>lua require("telescope.builtin").lsp_implementations()<cr>')

    -- Jumps to the definition of the type symbol
    buf_map('n', 'gt', '<cmd>lua require("telescope.builtin").lsp_type_definitions()<cr>')

    -- Lists all the references
    buf_map('n', 'gr', '<cmd>lua require("telescope.builtin").lsp_references()<cr>')

    -- Displays a function's signature information
    buf_map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

    -- Diagnostics
    buf_map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
    buf_map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
    buf_map('n', 'ge', '<cmd>lua vim.diagnostic.open_float(nil, { scope = "line", })<cr>')
    buf_map('n', '<leader>wd', '<cmd>Telescope diagnostics<cr>')

    -- formatting
    buf_map('n', '<leader>gf', '<cmd>lua vim.lsp.buf.format { async = true }<cr>')
    buf_map('v', '<leader>gf', '<cmd>lua vim.lsp.buf.range_formatting()<cr>')

    -- Renames all references to the symbol under the cursor
    buf_map('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<cr>')

    -- Selects a code action available at the current cursor position
    buf_map('n', 'ca', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    buf_map('x', 'ca', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')
  end
})
