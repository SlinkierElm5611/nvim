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
}

vim.api.nvim_create_autocmd({"BufWritePost"}, {
    callback =  function ()
        lint.try_lint()
    end,
})

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

-- treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "rust", "python", "c", "cpp", "javascript", "yaml", "bash", "lua" },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  },
}

-- rainbow delimiters
local rainbow_delimiters = require 'rainbow-delimiters'

vim.g.rainbow_delimiters = {
    strategy = {
        [''] = rainbow_delimiters.strategy['global'],
        vim = rainbow_delimiters.strategy['local'],
    },
    query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
    },
    highlight = {
        'RainbowDelimiterRed',
        'RainbowDelimiterYellow',
        'RainbowDelimiterBlue',
        'RainbowDelimiterOrange',
        'RainbowDelimiterGreen',
        'RainbowDelimiterViolet',
        'RainbowDelimiterCyan',
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

-- hypersonic
 require('hypersonic').setup({
    border = 'rounded',
    winblend = 0,
    add_padding = true,
    hl_group = 'Keyword',
    wrapping = '"'
})

-- lualine
require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = {'location'},
        lualine_b = {'branch'},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {'encoding',  'filetype'},
        lualine_z = {'filename'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}
