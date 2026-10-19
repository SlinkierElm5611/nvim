#!/usr/bin/env bash
# expects nvim 0.12+ to already be installed
set -e

# ripgrep for telescope live_grep; curl, tar and a C compiler for treesitter parsers
sudo apt install -y ripgrep curl tar build-essential

# tree-sitter CLI (nvim-treesitter builds parsers with it; the apt and npm versions are too old)
case "$(uname -m)" in
	aarch64 | arm64) ts_arch=arm64 ;;
	*) ts_arch=x64 ;;
esac
mkdir -p ~/.local/bin
curl -fsSL "https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-$ts_arch.gz" | gunzip > ~/.local/bin/tree-sitter
chmod +x ~/.local/bin/tree-sitter

# nodejs 22+ for copilot
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.8/install.sh | bash
export NVM_DIR="$HOME/.nvm"
. "$NVM_DIR/nvm.sh"
nvm install --lts

# lazy.nvim bootstraps itself, then installs every plugin
export PATH="$HOME/.local/bin:$PATH"
nvim --headless "+Lazy! sync" +qa
