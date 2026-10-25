## Stefan's Nvim Config
### Description
This is my neovim configuration which I use for all my programming needs: (c++, python, rust, js/ts, dart, web, cuda/glsl/wgsl)
You are free to use this config as you like, but I would recommend you fork/mirror it to modify it to your liking. Pull requests will be ignored.
### Features
- Plugins managed by lazy.nvim, which installs itself on first launch. Plugin versions are pinned in `lazy-lock.json`.
- LSP support through Neovim's built-in LSP client (`vim.lsp.config`), with servers installed through mason.nvim.
- Completion through blink.cmp.
- Linter support through nvim-lint.
- Debugging through nvim-dap and nvim-dap-ui, with debug adapters installed through mason.
- Treesitter for syntax highlighting.
- Telescope for fuzzy finding files and live-grepping files.
- Git integration with Fugitive, plus gitsigns for hunks and inline blame.
- and many more...
### Setup
#### Setup Script
1. Clone this repo to your nvim config directory. (usually `~/.config/nvim`)
2. Install nvim 0.12+, then run the setup script with `./setup_config.sh` to install dependencies and plugins. (Linux with apt, dnf, pacman, zypper or apk; macOS with Homebrew; Windows through WSL)
#### Manual Setup
1. Install nvim 0.12+ (distro packages are often too old; use the [official release](https://github.com/neovim/neovim/releases) or Homebrew), plus git, curl, tar and a C compiler.
2. Install the [tree-sitter CLI](https://github.com/tree-sitter/tree-sitter/releases) 0.26.1+ and put it on your `PATH`. nvim-treesitter uses it to build parsers. (don't use the npm package; most distro packages are too old)
3. Open nvim. lazy.nvim installs itself and every plugin on first launch. (`:Lazy` shows plugin status, `:Lazy sync` updates plugins)
4. Install `ripgrep` for telescope live-grep support. (available as `ripgrep` in most package managers and Homebrew)
5. Install and setup nodejs 22+ for npm-based language servers installed through mason (e.g. typescript, html). (recommended method: [nvm](https://github.com/nvm-sh/nvm), then `nvm install --lts`)
### Post Setup
1. Install `3270 Nerd Font Regular` from Nerd Fonts repo for icons to work properly. (optional)
2. To install an LSP for the open file type, type `:LspInstall` and select the LSP you want to install. Installed servers are enabled automatically.
3. For c++ linting (without this, the editor will complain when you write a buffer in cpp), install cppcheck. (available as `cppcheck` in most package managers and Homebrew)
4. For python linting (without this, the editor will complain when you write a buffer in python), install pylint. (can be installed through `pip install pylint`)
5. For dart, install the dart (or flutter) SDK; its language server is enabled automatically.
6. To debug, install the debug adapter for your language with `:DapInstall <adapter>`. (see [Debugging](#debugging))
### Debugging
Debugging uses nvim-dap, with nvim-dap-ui for the debugger windows and nvim-dap-virtual-text for variable values next to the code.
#### Debug Adapters
Run `:DapInstall <adapter>` once per language (`<Tab>` completes adapter names). Installed adapters are set up right away, no restart needed.
- C, C++ and Rust: `:DapInstall codelldb`. Build with debug info first (`-g` for gcc/clang, a plain `cargo build` for rust). Starting a session asks for the path to the executable (e.g. `build/app` or `target/debug/<crate>`); the last path is filled in again until you quit nvim.
- Rust: for readable values (`String`, `Vec`, ...), codelldb needs the LLDB formatters from your rust toolchain. rustup toolchains include them; with the distro rust on Ubuntu/Debian, install `rust-lldb`.
- Python: `:DapInstall python` (debugpy). Programs run with the active virtualenv, or a `.venv`/`venv` folder in the project, otherwise with the `python3` on your `PATH`.
- JavaScript and TypeScript: `:DapInstall js`. Debugs the current file with node (node 22.18+ runs TypeScript files directly).
- Dart and Flutter: nothing to install, both SDKs ship their own debug adapter. Flutter apps start from `lib/main.dart`, and when more than one device is connected (e.g. linux and chrome) you're asked which one to run on.
#### Usage
1. Open nvim in the project's root directory, which debug sessions use as the working directory.
2. Set a breakpoint with `<leader>db`.
3. Press `<F5>` and pick a configuration (e.g. `LLDB: Launch`, `file` for python, `Node: Launch file`, `Dart: Launch file`). The debug UI opens: variables, breakpoints, call stack and watches on the left; the REPL and a terminal with the program's output (type there for input) at the bottom.
4. Step with `<F10>` (over), `<F11>` (into) and `<F12>` (out), continue to the next breakpoint with `<F5>`, and show the value of the expression under the cursor (or the visual selection) with `<leader>de`.
5. Stop with `<leader>dt`, or re-run the last session with `<leader>dl`. The UI stays open after the program exits so its output can still be read; close it with `<leader>du`.

In the debug UI windows, `<CR>` expands a variable, `e` edits a value, `o` jumps to a stack frame or breakpoint, `d` removes a watch or breakpoint, and entering insert mode in the watches window adds an expression to watch. If your terminal takes `<F10>`/`<F11>` for itself (e.g. GNOME Terminal's menu and fullscreen shortcuts), use `:DapStepOver`/`:DapStepInto` or disable those shortcuts. If a session doesn't start, `:DapShowLog` shows the debug log.
#### Project Debug Configurations
To skip the prompts, or to pass arguments and environment variables, add a `.vscode/launch.json` to the project root. Its configurations are listed next to the defaults when you press `<F5>`:
```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Debug app",
      "type": "codelldb",
      "request": "launch",
      "program": "${workspaceFolder}/build/app",
      "args": ["--verbose"],
      "cwd": "${workspaceFolder}"
    }
  ]
}
```
`type` picks the adapter: `codelldb`, `python`, `pwa-node`, `dart` or `flutter` (VS Code's `lldb` and `node` types are called `codelldb` and `pwa-node` here). Comments are fine, trailing commas are not.
### Project Structure
- `lua/SlinkierElm5611/set.lua` - nvim settings.
- `lua/SlinkierElm5611/remap.lua` - key mappings.
- `lua/SlinkierElm5611/lsp.lua` - diagnostics and LSP key mappings.
- `lua/SlinkierElm5611/lazy.lua` - bootstraps lazy.nvim and loads the plugin specs.
- `lua/SlinkierElm5611/plugins/` - one lazy.nvim spec file per area (ui, editor, git, lsp, debug, colorscheme), with each plugin's configuration next to it.
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
- `]c` / `[c` - Next / previous git hunk.
- `<leader>hp` / `<leader>hs` / `<leader>hu` - Preview / stage / undo git hunk.
- `gl` - Show diagnostic under cursor. `]d` / `[d` - Next / previous diagnostic.
#### LSP (when a language server is attached)
- `K` - Hover documentation.
- `gd` / `gD` / `gi` / `go` - Go to definition / declaration / implementation / type definition.
- `gr` - References.
- `gs` - Signature help.
- `<F2>` - Rename. `<F3>` - Format. `<F4>` - Code action.
#### Debugging
(defined in `lua/SlinkierElm5611/plugins/debug.lua`)
- `<F5>` - Start debugging / continue to the next breakpoint.
- `<F10>` / `<F11>` / `<F12>` - Step over / into / out.
- `<leader>db` - Toggle breakpoint. `<leader>dB` - Set a conditional breakpoint.
- `<leader>dc` - Run to cursor.
- `<leader>dl` - Re-run the last debug session.
- `<leader>dt` - Stop debugging.
- `<leader>du` - Toggle the debug UI.
- `<leader>de` - Show the value of the expression under the cursor (or the selection in visual mode).
#### Insert Mode
- `<C-Space>` - Open completion menu. `<C-n>` / `<C-p>` - Next / previous item. `<CR>` - Accept selected item.
#### Visual Mode
- `<leader>r` - Hypersonic regex validation
- `<leader>hs` - Stage selected lines.
#### Terminal Mode
- `<Esc>` - Return to normal mode.
