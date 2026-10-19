vim.g.mapleader = " "

local map = vim.keymap.set

-- copilot
map("i", "<C-a>", 'copilot#Accept("\\<CR>")', { expr = true, silent = true, replace_keycodes = false, desc = "Accept Copilot suggestion" })

-- fugitive
map("n", "<leader>gs", vim.cmd.Git, { desc = "Git status" })
map("n", "<leader>gc", "<cmd>Git commit %<CR>", { desc = "Git commit current file" })
map("n", "<leader>gca", "<cmd>Git commit -a<CR>", { desc = "Git commit all" })
map("n", "<leader>gp", "<cmd>Git push<CR>", { desc = "Git push" })

-- telescope
map("n", "<leader>pf", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<C-p>", "<cmd>Telescope git_files<CR>", { desc = "Find git files" })
map("n", "<leader>ps", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })

-- hypersonic
map("x", "<leader>r", ":Hypersonic<CR>", { silent = true, desc = "Explain regex" })

-- window keymaps
map("n", "<leader>sv", "<cmd>split<CR>", { desc = "Split window" })
map("n", "<leader>sh", "<cmd>vsplit<CR>", { desc = "Split window vertically" })
map("n", "<leader>pv", vim.cmd.Ex, { desc = "Open netrw" })

-- buffer keymaps
map("n", "<leader>bw", "<cmd>bufdo bwipeout<CR>", { desc = "Wipe out all buffers" })

-- gen remaps
map("n", "<leader>sm", function() require("gen").select_model() end, { desc = "Select Ollama model" })

-- noice remaps
map("n", "<leader>nc", "<cmd>NoiceDismiss<CR>", { desc = "Dismiss notifications" })

-- terminal remaps
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
