return {
	{
		"github/copilot.vim",
		init = function()
			-- <C-a> accepts instead of <Tab> (see remap.lua)
			vim.g.copilot_no_tab_map = true
		end,
	},

	-- ollama
	{
		"David-Kunz/gen.nvim",
		cmd = "Gen",
		opts = {
			model = "mistral-nemo",
			host = "baltaovpn.tplinkdns.com",
			port = 11434,
		},
	},
}
