vim.keymap.set("i", "<C-a>", "copilot#Accept('<CR>')", {expr=true,silent=true,noremap=true,replace_keycodes=false})
vim.g.copilot_assume_mapped = true
vim.g.copilot_no_tab_map = true
