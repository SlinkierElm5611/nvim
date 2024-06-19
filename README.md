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
1. `WIP`
#### Manual Setup
1. Install nvim (version 0.9+)
2. Install packer.nvim `git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim`
3. Open nvim and run `:PackerSync` to install plugins
4. Install `3270 Nerd Font Regular` from Nerd Fonts repo for icons to work properly. (optional)
5. Install `ripgrep` for telescope live-grep support. (can be installed through `sudo apt install ripgrep`)
6. Install and setup latest version of nodejs for Copilot support. (recoomeneded method: `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash && nvm install node`
7. To setup Copilot, run `:Copilot setup` and follow the instructions.
8. To install an LSP for the open file type, type `:LspInstall` and select the LSP you want to install.
9. For c++ linting (without this, the editor will complain when you write a buffer in cpp), install cppcheck. (can be installed through `sudo apt install cppcheck`)
10. For python linting (without this, the editor will complain when you write a buffer in python), install pylint. (can be installed through `pip install pylint`)
