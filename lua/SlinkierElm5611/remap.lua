vim.g.mapleader = " "

-- copilot
vim.keymap.set("i", "<C-a>", "copilot#Accept('<CR>')", {expr=true,silent=true,noremap=true,replace_keycodes=false})

-- fugitive
vim.keymap.set("n", "<leader>gs", vim.cmd.Git);
vim.keymap.set("n", "<leader>gc", "<cmd>Git commit %<CR>");
vim.keymap.set("n", "<leader>gca", "<cmd>Git commit -a<CR>");
vim.keymap.set("n", "<leader>gp", "<cmd>Git push<CR>")

-- telescope
vim.keymap.set('n', '<leader>pf', "<cmd>Telescope find_files<CR>", {})
vim.keymap.set("n", "<C-p>", "<cmd>Telescope git_files<CR>", {})
vim.keymap.set('n', '<leader>ps', "<cmd>Telescope live_grep<CR>", {})

-- hypersonic
vim.keymap.set('v', '<leader>r', ':Hypersonic <CR>', { silent = true })

-- window keymaps
vim.keymap.set('n', '<leader>sv', ':split<CR>', { silent = true })
vim.keymap.set('n', '<leader>sh', ':vsplit<CR>', { silent = true })
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- buffer keymaps
vim.keymap.set('n', '<leader>bw', ':bufdo bwipeout<CR>', { silent = true })

-- gen remaps
vim.keymap.set('n', '<leader>sm', ":lua require('gen').select_model() <CR>")

-- noice remaps
vim.keymap.set('n', '<leader>nc', ':NoiceDismiss<CR>', { silent = true })
