local go = require('go')

go.setup({
  max_line_len = 120,

  lsp_cfg = false,
  lsp_gofumpt = true,
  lsp_on_attach = nil,
  lsp_diag_hdlr = true,
  lsp_diag_underline = true,
  lsp_diag_virtual_text = { space = 0, prefix = "" },
  lsp_diag_signs = true,
  lsp_diag_update_in_insert = false,
  lsp_document_formatting = false,
  lsp_inlay_hints = {
    enable = false,
  },

  dap_debug = false,
  textobjects = true,
  test_runner = 'go',
  verbose_tests = true,
  run_in_floaterm = true,
  luasnip = true,
})
