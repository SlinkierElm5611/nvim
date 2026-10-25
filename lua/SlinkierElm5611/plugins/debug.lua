return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{ "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
			"theHamsta/nvim-dap-virtual-text",
			"mfussenegger/nvim-dap-python",
			-- installs adapters with :DapInstall and sets up every installed adapter
			{ "jay-babu/mason-nvim-dap.nvim", dependencies = { "mason-org/mason.nvim" } },
		},
		cmd = { "DapInstall", "DapUninstall" },
		keys = {
			{ "<F5>", function() require("dap").continue() end, desc = "Start/continue debugging" },
			{ "<F10>", function() require("dap").step_over() end, desc = "Step over" },
			{ "<F11>", function() require("dap").step_into() end, desc = "Step into" },
			{ "<F12>", function() require("dap").step_out() end, desc = "Step out" },
			{ "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
			{ "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Conditional breakpoint" },
			{ "<leader>dc", function() require("dap").run_to_cursor() end, desc = "Run to cursor" },
			{ "<leader>dl", function() require("dap").run_last() end, desc = "Re-run last debug session" },
			{ "<leader>dt", function() require("dap").terminate() end, desc = "Stop debugging" },
			{ "<leader>du", function() require("dapui").toggle() end, desc = "Toggle debug UI" },
			{ "<leader>de", function() require("dapui").eval() end, mode = { "n", "x" }, desc = "Evaluate expression" },
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup()
			require("nvim-dap-virtual-text").setup()

			-- open the UI when a session starts; it stays open after the program exits so
			-- its output can still be read, <leader>du closes it
			dap.listeners.before.attach["SlinkierElm5611"] = function() dapui.open() end
			dap.listeners.before.launch["SlinkierElm5611"] = function() dapui.open() end

			-- DapStoppedLine comes from tokyonight
			vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
			vim.fn.sign_define("DapBreakpointCondition", { text = "●", texthl = "DiagnosticWarn" })
			vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DiagnosticInfo" })
			vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "Comment" })
			vim.fn.sign_define("DapStopped", { text = "→", texthl = "DiagnosticWarn", linehl = "DapStoppedLine", numhl = "DapStoppedLine" })

			-- adapters installed through mason get mason-nvim-dap's default configurations,
			-- apart from the handlers below
			local program
			require("mason-nvim-dap").setup({
				handlers = {
					-- c, c++ and rust: offer the last executable again instead of asking from scratch
					codelldb = function(config)
						for _, configuration in ipairs(config.configurations) do
							configuration.program = function()
								local path = vim.fn.input("Path to executable: ", program or vim.fn.getcwd() .. "/", "file")
								if path == "" then
									return dap.ABORT
								end
								program = path
								return path
							end
						end
						require("mason-nvim-dap").default_setup(config)
						-- codelldb only loads rust's pretty printers (String, Vec, ...) when told the program is rust
						dap.configurations.rust = vim.tbl_map(function(configuration)
							return vim.tbl_extend("force", configuration, { sourceLanguages = { "rust" } })
						end, dap.configurations.rust)
					end,

					-- nvim-dap-python uses an active venv (VIRTUAL_ENV/CONDA_PREFIX) first; without one, use the
					-- project's .venv/venv, then python3 from PATH instead of debugpy's own isolated venv
					python = function()
						local dap_python = require("dap-python")
						dap_python.resolve_python = function()
							for _, venv in ipairs({ ".venv", "venv" }) do
								local python = vim.fn.getcwd() .. "/" .. venv .. "/bin/python"
								if vim.fn.executable(python) == 1 then
									return python
								end
							end
							return vim.fn.exepath("python3")
						end
						dap_python.setup("debugpy-adapter")
					end,

					-- mason-nvim-dap has no defaults for js-debug-adapter;
					-- the host is explicit so node and nvim-dap agree on ipv4
					js = function()
						dap.adapters["pwa-node"] = {
							type = "server",
							host = "127.0.0.1",
							port = "${port}",
							executable = { command = "js-debug-adapter", args = { "${port}", "127.0.0.1" } },
						}
						for _, ft in ipairs({ "javascript", "typescript" }) do
							dap.configurations[ft] = vim.list_extend(dap.configurations[ft] or {}, {
								{
									type = "pwa-node",
									request = "launch",
									name = "Node: Launch file",
									program = "${file}",
									cwd = "${workspaceFolder}",
									console = "integratedTerminal",
									skipFiles = { "<node_internals>/**" },
								},
							})
						end
					end,
				},
			})

			-- the dart and flutter SDKs ship their own debug adapters, like dartls in lsp.lua
			dap.adapters.dart = { type = "executable", command = "dart", args = { "debug_adapter" } }
			dap.adapters.flutter = { type = "executable", command = "flutter", args = { "debug_adapter" } }
			dap.configurations.dart = {
				{
					type = "dart",
					request = "launch",
					name = "Dart: Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
					console = "terminal",
					-- the adapter pauses the program on exit and reports that as a stop nvim-dap
					-- can't show, which would end every run with a warning
					toolArgs = { "--no-pause-isolates-on-exit" },
				},
				{
					type = "flutter",
					request = "launch",
					name = "Flutter: Launch app",
					program = "${workspaceFolder}/lib/main.dart",
					cwd = "${workspaceFolder}",
					-- flutter run won't pick a device by itself when several are connected (e.g. linux and chrome)
					toolArgs = function()
						local result = vim.system({ "flutter", "devices", "--machine" }, { text = true }):wait(10000)
						local ok, devices = pcall(vim.json.decode, result.stdout)
						if not ok or #devices < 2 then
							return {}
						end
						return coroutine.create(function(dap_run_co)
							vim.ui.select(devices, {
								prompt = "Device: ",
								format_item = function(device) return device.name end,
							}, function(device)
								coroutine.resume(dap_run_co, device and { "-d", device.id } or dap.ABORT)
							end)
						end)
					end,
				},
			}
			-- flutter web reports finished steps as "pause" stops, which nvim-dap doesn't jump to
			dap.listeners.before.event_stopped["SlinkierElm5611"] = function(session, body)
				if session.config.type == "flutter" and body.reason == "pause" then
					body.reason = "step"
				end
			end
		end,
	},
}
