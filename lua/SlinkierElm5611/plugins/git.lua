return {
	"tpope/vim-fugitive",

	-- replaces vim-gitgutter (signs/hunks) and blamer.nvim (inline blame)
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			-- blame stays off on Windows, as it was with blamer
			current_line_blame = vim.fn.has("win32") == 0,
			current_line_blame_opts = { delay = 0 },
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")
				local function map(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
				end

				-- same keys as vim-gitgutter's defaults
				map("n", "]c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end, "Next hunk")
				map("n", "[c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end, "Previous hunk")
				map("n", "<leader>hp", gitsigns.preview_hunk, "Preview hunk")
				map("n", "<leader>hs", gitsigns.stage_hunk, "Stage hunk")
				map("x", "<leader>hs", function()
					gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "Stage selected lines")
				map("n", "<leader>hu", gitsigns.reset_hunk, "Undo hunk")
				map({ "o", "x" }, "ic", gitsigns.select_hunk, "Hunk")
				map({ "o", "x" }, "ac", gitsigns.select_hunk, "Hunk")
			end,
		},
	},
}
