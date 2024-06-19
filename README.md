## Stefan's Nvim Config
### Description
This is my neovim configuration which I use for all my programming needs: (c++, python, rust, js/ts, web, cuda/glsl/wgsl)
You are free to use this config as you like, but I would recommend you fork/mirror it to modify it to your liking. Pull requests will be ignored.
### Features
- LSP support with file type detection through lsp-zero.
- Linter support through nvim-lint.
- Treesitter for syntax highlighting and code folding.
- Telescope for fuzzy finding files and live-grepping files.
- Github Copilot integration.
- Git integration with Fugitive.
- Gen integration for local Ollama LLM integration (locally run github copilot).
- and many more...
### Setup
#### Setup Script
1. Clone this repo to your nvim config directory. (usually `~/.config/nvim`)
2. Run the setup script with `./setup_config.sh` to install dependencies and setup config.
#### Manual Setup
1. Install nvim (version 0.9+)
2. Install packer.nvim `git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim`
3. Open nvim and run `:PackerSync` to install plugins
4. Install `ripgrep` for telescope live-grep support. (can be installed through `sudo apt install ripgrep`)
5. Install and setup latest version of nodejs for Copilot support. (recoomeneded method: `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash && nvm install node`
### Post Setup
1. Install `3270 Nerd Font Regular` from Nerd Fonts repo for icons to work properly. (optional)
2. To setup Copilot, run `:Copilot setup` and follow the instructions.
3. To install an LSP for the open file type, type `:LspInstall` and select the LSP you want to install.
4. For c++ linting (without this, the editor will complain when you write a buffer in cpp), install cppcheck. (can be installed through `sudo apt install cppcheck`)
5. For python linting (without this, the editor will complain when you write a buffer in python), install pylint. (can be installed through `pip install pylint`)
6. Install Ollama for local LLM support.
### Project Structure
- `lua/SlinkierElm5611` contains all the startup Lua files in the config(key mappings, nvim settings, packer integration).
- `after/plugin/config.lua` contains all the plugin configurations (runs after nvim startup is finished.
### Custom Keybindings
(All keybindings can be found in `lua/SlinkierElm5611/remap.lua`)
#### Normal Mode
- `<leader>` is set to spacebar.
- `<leader>pf` - Fuzzy find files in the project.
- `<leader>ps` - Live Grep current directory.
- `<C-p>` - Fuzzy find files tracked by the current git repo.
- `<leader>gc` - Git commit current buffer.
- `<leader>gca` - Git commit all changes.
- `<leader>gp` - Git push current branch.
- `<leader>gs` - Git status.
- `<leader>sv>` - Split vertical.
- `<leader>sh` - Split horizontal.
- `<leader>pv` - Open netrw.
- `<leader>bw` - Wipeout all open buffers. (returns nvim to a clean state)
- `<leader>nc` - Clear Noice notifications (to quickly clear screen).
#### Insert Mode
- `<C-a>` - Accept copilot suggestion.
#### Visual Mode
- `<leader>r` - Hypersonic regex validation
