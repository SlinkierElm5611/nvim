vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'folke/tokyonight.nvim'
    use 'APZelos/blamer.nvim'
    use 'airblade/vim-gitgutter'
    use 'vim-airline/vim-airline'
    use "lukas-reineke/indent-blankline.nvim"
    use 'tomiis4/Hypersonic.nvim'
    use 'github/copilot.vim'
    use 'tpope/vim-surround'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use ('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
    use ('tpope/vim-fugitive')
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {                                      -- Optional
            'williamboman/mason.nvim',
            run = function()
                pcall(vim.cmd, 'MasonUpdate')
            end},
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},     -- Required
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'L3MON4D3/LuaSnip'},     -- Required
        }
    }
    use 'mfussenegger/nvim-lint'
 --   use "mfussenegger/nvim-dap"
 --   use "jay-babu/mason-nvim-dap.nvim"
 --   use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
    use {
        "startup-nvim/startup.nvim",
        requires = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"},
    }
end)
