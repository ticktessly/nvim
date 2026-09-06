return {
	{
		"mfussenegger/nvim-dap",
		keys = {
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Toggle Breakpoint",
			},
			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
				desc = "Start / Continue",
			},
			{
				"<leader>dt",
				function()
					require("dap-go").debug_test()
				end,
				desc = "Debug Test (Go)",
			},
		},
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"leoluz/nvim-dap-go",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			require("dap-go").setup()
			dapui.setup()

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			local map = vim.keymap.set
			map("n", "<leader>dn", dap.step_over, { desc = "DAP: Step Over" })
			map("n", "<leader>si", dap.step_into, { desc = "DAP: Step Into" })
			map("n", "<leader>so", dap.step_out, { desc = "DAP: Step Out" })
			map("n", "<leader>du", dapui.toggle, { desc = "DAP: Toggle UI" })
		end,
	},
}
