#!/usr/bin/env bash
# expects nvim 0.12+ to already be installed
# supports linux (apt, dnf, pacman, zypper, apk) and macos (homebrew)
set -e

# use sudo only when not already root (containers often have no sudo)
if [ "$(id -u)" -eq 0 ]; then
	sudo=""
else
	sudo="sudo"
fi

# ripgrep for telescope live_grep; curl, tar and a C compiler for treesitter parsers
case "$(uname -s)" in
	Linux) ts_os=linux ;;
	Darwin) ts_os=macos ;;
	*)
		echo "unsupported OS: $(uname -s) (on Windows, run this inside WSL)" >&2
		exit 1
		;;
esac

if [ "$ts_os" = macos ]; then
	# homebrew needs the xcode command line tools, which provide the C compiler
	xcode-select -p > /dev/null 2>&1 || xcode-select --install
	command -v brew > /dev/null || {
		echo "install homebrew first: https://brew.sh" >&2
		exit 1
	}
	brew install ripgrep curl
elif command -v apt-get > /dev/null; then
	$sudo apt-get update
	$sudo apt-get install -y ripgrep curl tar gzip build-essential
elif command -v dnf > /dev/null; then
	$sudo dnf install -y ripgrep curl tar gzip gcc gcc-c++ make
elif command -v pacman > /dev/null; then
	$sudo pacman -Sy --needed --noconfirm ripgrep curl tar gzip base-devel
elif command -v zypper > /dev/null; then
	$sudo zypper install -y ripgrep curl tar gzip gcc gcc-c++ make
elif command -v apk > /dev/null; then
	$sudo apk add ripgrep curl tar gzip build-base bash
else
	echo "no supported package manager found; install ripgrep, curl, tar, gzip and a C compiler manually" >&2
	exit 1
fi

# tree-sitter CLI (nvim-treesitter builds parsers with it; distro and npm versions are too old)
case "$(uname -m)" in
	aarch64 | arm64) ts_arch=arm64 ;;
	*) ts_arch=x64 ;;
esac
$sudo mkdir -p /usr/local/bin
curl -fsSL "https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-$ts_os-$ts_arch.gz" | gunzip | $sudo tee /usr/local/bin/tree-sitter > /dev/null
$sudo chmod +x /usr/local/bin/tree-sitter

# nodejs 22+ for npm-based language servers installed through mason
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.8/install.sh | bash
export NVM_DIR="$HOME/.nvm"
. "$NVM_DIR/nvm.sh"
nvm install --lts

# lazy.nvim bootstraps itself, then installs every plugin
nvim --headless "+Lazy! sync" +qa
