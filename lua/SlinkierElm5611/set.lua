vim.opt.updatetime = 16
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.mouse = ""
vim.opt.termguicolors = true

-- add unknown filetypes
vim.filetype.add({
	extension = {
		wgsl = "wgsl",
	},
})

-- loading the clipboard provider is slow, so defer it until after startup
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)
