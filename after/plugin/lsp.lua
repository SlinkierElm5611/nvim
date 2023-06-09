local lsp = require('lsp-zero')

lsp.preset('recommended')
lsp.setup()

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
