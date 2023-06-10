vim.opt.updatetime=100
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

--copilot settings
vim.g.copilot_assume_mapped = true
vim.g.copilot_no_tab_map = true

--git blamer settings
vim.g.blamer_delay = 0

-- add unkonwn filetypes
vim.filetype.add({
    extension = {
        wgsl = "wgsl"
    }
})
