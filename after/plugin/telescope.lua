local telescope = require('telescope')
telescope.setup{
    pickers = {
        find_files = {
            hidden = true,
        },
        git_files = {
            hidden = true,
        },
        grep_string = {
            hidden = true,
        },
    },
}
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})
