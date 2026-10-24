## Stefan's Nvim Config
### Description
This is my neovim configuration which I use for all my programming needs: (c++, python, rust, js/ts, dart, web, cuda/glsl/wgsl)
You are free to use this config as you like, but I would recommend you fork/mirror it to modify it to your liking. Pull requests will be ignored.
### Features
- Plugins managed by lazy.nvim, which installs itself on first launch. Plugin versions are pinned in `lazy-lock.json`.
- LSP support through Neovim's built-in LSP client (`vim.lsp.config`), with servers installed through mason.nvim.
- Completion through blink.cmp.
- Linter support through nvim-lint.
- Treesitter for syntax highlighting.
- Telescope for fuzzy finding files and live-grepping files.
- Github Copilot integration.
- Git integration with Fugitive, plus gitsigns for hunks and inline blame.
- Gen integration for local Ollama LLM integration (locally run github copilot).
- and many more...
### Setup
#### Setup Script
1. Clone this repo to your nvim config directory. (usually `~/.config/nvim`)
2. Install nvim 0.12+, then run the setup script with `./setup_config.sh` to install dependencies and plugins. (Ubuntu/Debian)
#### Manual Setup
1. Install nvim 0.12+ (distro packages are often too old; use the [official release](https://github.com/neovim/neovim/releases) or Homebrew), plus git, curl, tar and a C compiler.
2. Install the [tree-sitter CLI](https://github.com/tree-sitter/tree-sitter/releases) 0.26.1+ and put it on your `PATH`. nvim-treesitter uses it to build parsers. (don't use the npm package; most distro packages are too old)
3. Open nvim. lazy.nvim installs itself and every plugin on first launch. (`:Lazy` shows plugin status, `:Lazy sync` updates plugins)
4. Install `ripgrep` for telescope live-grep support. (can be installed through `sudo apt install ripgrep`)
5. Install and setup nodejs 22+ for Copilot support. (recommended method: [nvm](https://github.com/nvm-sh/nvm), then `nvm install --lts`)
### Post Setup
1. Install `3270 Nerd Font Regular` from Nerd Fonts repo for icons to work properly. (optional)
2. To setup Copilot, run `:Copilot setup` and follow the instructions.
3. To install an LSP for the open file type, type `:LspInstall` and select the LSP you want to install. Installed servers are enabled automatically.
4. For c++ linting (without this, the editor will complain when you write a buffer in cpp), install cppcheck. (can be installed through `sudo apt install cppcheck`)
5. For python linting (without this, the editor will complain when you write a buffer in python), install pylint. (can be installed through `pip install pylint`)
6. For dart, install the dart (or flutter) SDK; its language server is enabled automatically.
7. Install Ollama for local LLM support.
### Project Structure
- `lua/SlinkierElm5611/set.lua` - nvim settings.
- `lua/SlinkierElm5611/remap.lua` - key mappings.
- `lua/SlinkierElm5611/lsp.lua` - diagnostics and LSP key mappings.
- `lua/SlinkierElm5611/lazy.lua` - bootstraps lazy.nvim and loads the plugin specs.
- `lua/SlinkierElm5611/plugins/` - one lazy.nvim spec file per area (ui, editor, git, lsp, ai, colorscheme), with each plugin's configuration next to it.
### Custom Keybindings
(Global keybindings can be found in `lua/SlinkierElm5611/remap.lua`)
#### Normal Mode
- `<leader>` is set to spacebar.
- `<leader>pf` - Fuzzy find files in the project.
- `<leader>ps` - Live Grep current directory.
- `<C-p>` - Fuzzy find files tracked by the current git repo.
- `<leader>gc` - Git commit current buffer.
- `<leader>gca` - Git commit all changes.
- `<leader>gp` - Git push current branch.
- `<leader>gs` - Git status.
- `<leader>sv` - Split window (`:split`).
- `<leader>sh` - Split window vertically (`:vsplit`).
- `<leader>pv` - Open netrw.
- `<leader>bw` - Wipeout all open buffers. (returns nvim to a clean state)
- `<leader>nc` - Clear Noice notifications (to quickly clear screen).
- `<leader>sm` - Select the Ollama model used by Gen.
- `]c` / `[c` - Next / previous git hunk.
- `<leader>hp` / `<leader>hs` / `<leader>hu` - Preview / stage / undo git hunk.
- `gl` - Show diagnostic under cursor. `]d` / `[d` - Next / previous diagnostic.
#### LSP (when a language server is attached)
- `K` - Hover documentation.
- `gd` / `gD` / `gi` / `go` - Go to definition / declaration / implementation / type definition.
- `gr` - References.
- `gs` - Signature help.
- `<F2>` - Rename. `<F3>` - Format. `<F4>` - Code action.
#### Insert Mode
- `<C-a>` - Accept copilot suggestion.
- `<C-Space>` - Open completion menu. `<C-n>` / `<C-p>` - Next / previous item. `<CR>` - Accept selected item.
#### Visual Mode
- `<leader>r` - Hypersonic regex validation
- `<leader>hs` - Stage selected lines.
#### Terminal Mode
- `<Esc>` - Return to normal mode.
