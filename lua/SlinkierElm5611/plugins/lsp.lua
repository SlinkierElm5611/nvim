return {
	-- installs servers with :Mason / :LspInstall and enables every installed server
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		opts = {},
	},

	{
		"saghen/blink.cmp",
		version = "1.*",
		opts = {
			keymap = {
				-- <CR> accepts the selected item, <C-Space> opens the menu,
				-- <C-n>/<C-p> move through items
				preset = "enter",
				["<C-y>"] = { "select_and_accept" },
			},
			completion = {
				-- nothing is selected until <C-n>/<C-p>, so <CR> on an
				-- untouched menu still inserts a newline
				list = { selection = { preselect = false, auto_insert = true } },
				documentation = { auto_show = true },
			},
			-- leave the command line to noice / native wildmenu
			cmdline = { enabled = false },
		},
	},

	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				python = { "pylint" },
				cpp = { "cppcheck" },
			}

			vim.api.nvim_create_autocmd("BufWritePost", {
				group = vim.api.nvim_create_augroup("SlinkierElm5611.lint", { clear = true }),
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},
}
