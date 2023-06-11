-- lsp setup
-- mason.setup is run when lsp.setup is run
local lsp = require('lsp-zero')

lsp.preset('recommended')
lsp.setup()

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

-- lint
local lint = require('lint')
lint.linters_by_ft = {
    python = {'pylint'},
    rust = {'cargo'},
    javascript = {'eslint'},
}

vim.api.nvim_create_autocmd({"BufWritePost"}, {
    callback =  function ()
        lint.try_lint()
    end,
})

-- dap
--require("mason-nvim-dap").setup()
--local dap, dapui = require("dap"), require("dapui")
--
--dap.listeners.after.event_initialized["dapui_config"] = function()
--    dapui.open()
--end
--dap.listeners.before.event_terminated["dapui_config"] = function()
--    dapui.close()
--end
--dap.listeners.before.event_exited["dapui_config"] = function()
--    dapui.close()
--end

-- copilot
vim.keymap.set("i", "<C-a>", "copilot#Accept('<CR>')", {expr=true,silent=true,noremap=true,replace_keycodes=false})

-- fugitive
vim.keymap.set("n", "<leader>gs", vim.cmd.Git);

-- telescope
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

-- treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "rust", "python", "c", "cpp", "javascript", "yaml", "bash", "lua" },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

-- blamer
vim.cmd[[BlamerShow]]

-- colour scheme
vim.cmd[[colorscheme tokyonight-night]]
vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

require("indent_blankline").setup {
    space_char_blankline = " ",
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
    },
}

-- startup screen
require("startup").setup({theme = 'evil'})
