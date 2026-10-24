return {
	{ "tpope/vim-surround", event = "VeryLazy" },

	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-file-browser.nvim", -- used by the startup screen
		},
		opts = {
			pickers = {
				find_files = {
					hidden = true,
					no_ignore = true,
				},
				git_files = {
					hidden = true,
				},
				grep_string = {
					hidden = true,
				},
			},
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("file_browser")
		end,
	},

	{
		-- the main branch builds parsers with the tree-sitter CLI (see README)
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local ts = require("nvim-treesitter")

			local parsers = { "rust", "python", "c", "cpp", "javascript", "yaml", "bash", "lua" }
			local installing = {} -- lang -> install task, so a parser is only fetched once
			local startup_install = ts.install(parsers)
			for _, lang in ipairs(parsers) do
				installing[lang] = startup_install
			end

			local function start(buf, lang)
				if vim.api.nvim_buf_is_valid(buf) and vim.treesitter.language.add(lang) then
					pcall(vim.treesitter.start, buf, lang)
				end
			end

			-- main has no highlight/auto_install options: start highlighting in every buffer
			-- with a parser, installing the parser first when it isn't installed yet
			local available
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("SlinkierElm5611.treesitter", { clear = true }),
				callback = function(event)
					local lang = vim.treesitter.language.get_lang(event.match)
					if not lang then
						return
					end
					if vim.treesitter.language.add(lang) then
						return start(event.buf, lang)
					end

					available = available or ts.get_available()
					if vim.list_contains(available, lang) then
						installing[lang] = installing[lang] or ts.install(lang)
						installing[lang]:await(vim.schedule_wrap(function()
							start(event.buf, lang)
						end))
					end
				end,
			})
		end,
	},

	{
		"tomiis4/Hypersonic.nvim",
		cmd = "Hypersonic",
		event = "CmdlineEnter", -- live cmdline explanation needs setup at startup
		main = "hypersonic",
		opts = {
			border = "rounded",
			winblend = 0,
			add_padding = true,
			hl_group = "Keyword",
			wrapping = '"',
		},
	},

	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = "markdown",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
}
