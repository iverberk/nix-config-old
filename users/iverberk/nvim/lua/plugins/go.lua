local go = require('go')

go.setup({
  max_line_len = 120,

  lsp_cfg = true,
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

  dap_debug = false, -- set to false to disable dap
  build_tags = "tag1,tag2", -- set default build tags
  textobjects = true, -- enable default text jobects through treesittter-text-objects
  test_runner = 'go', -- one of {`go`, `richgo`, `dlv`, `ginkgo`, `gotestsum`}
  verbose_tests = true, -- set to add verbose flag to tests deprecated, see '-v' option
  run_in_floaterm = true, -- set to true to run in float window. :GoTermClose closes the floatterm
  luasnip = true,
})
