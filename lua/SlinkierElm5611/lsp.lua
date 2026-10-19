-- diagnostics
vim.diagnostic.config({
	-- Neovim 0.11 turned inline diagnostics off by default
	virtual_text = true,
	severity_sort = true,
})
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Show diagnostic" })
vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Next diagnostic" })

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	group = vim.api.nvim_create_augroup("SlinkierElm5611.lsp", { clear = true }),
	callback = function(event)
		-- these are buffer-local keybindings
		-- because they only work if you have an active language server
		local function map(mode, lhs, rhs, desc, opts)
			opts = vim.tbl_extend("force", { buffer = event.buf, desc = desc }, opts or {})
			vim.keymap.set(mode, lhs, rhs, opts)
		end

		map("n", "K", vim.lsp.buf.hover, "Hover")
		map("n", "gd", vim.lsp.buf.definition, "Go to definition")
		map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
		map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
		map("n", "go", vim.lsp.buf.type_definition, "Go to type definition")
		-- nowait: otherwise this waits for Neovim's built-in grn/grr/gra/gri maps to time out
		map("n", "gr", vim.lsp.buf.references, "References", { nowait = true })
		map("n", "gs", vim.lsp.buf.signature_help, "Signature help")
		map("n", "<F2>", vim.lsp.buf.rename, "Rename")
		map({ "n", "x" }, "<F3>", function() vim.lsp.buf.format({ async = true }) end, "Format")
		map("n", "<F4>", vim.lsp.buf.code_action, "Code action")
	end,
})

-- servers installed through mason are enabled by mason-lspconfig (see plugins/lsp.lua);
-- the dart server ships with the dart SDK, so enable nvim-lspconfig's config for it here
vim.lsp.enable("dartls")
