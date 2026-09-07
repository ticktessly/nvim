local mod_cache = nil
local std_lib = nil

local function identify_go_dir(custom_args, on_complete)
	local cmd = { "go", "env", custom_args.envvar_id }
	vim.system(cmd, { text = true }, function(output)
		local res = vim.trim(output.stdout or "")
		if output.code == 0 and res ~= "" then
			if custom_args.custom_subdir and custom_args.custom_subdir ~= "" then
				res = res .. custom_args.custom_subdir
			end
			on_complete(res)
		else
			vim.schedule(function()
				vim.notify(
					("[gopls] identify " .. custom_args.envvar_id .. " dir cmd failed with code %d: %s\n%s"):format(
						output.code,
						vim.inspect(cmd),
						output.stderr
					)
				)
			end)
			on_complete(nil)
		end
	end)
end

local function get_std_lib_dir()
	if std_lib and std_lib ~= "" then
		return std_lib
	end
	identify_go_dir({ envvar_id = "GOROOT", custom_subdir = "/src" }, function(dir)
		if dir then
			std_lib = dir
		end
	end)
	return std_lib
end

local function get_mod_cache_dir()
	if mod_cache and mod_cache ~= "" then
		return mod_cache
	end
	identify_go_dir({ envvar_id = "GOMODCACHE" }, function(dir)
		if dir then
			mod_cache = dir
		end
	end)
	return mod_cache
end

local function get_root_dir(fname)
	if mod_cache and fname:sub(1, #mod_cache) == mod_cache then
		local clients = vim.lsp.get_clients({ name = "gopls" })
		if #clients > 0 then
			return clients[#clients].config.root_dir
		end
	end
	if std_lib and fname:sub(1, #std_lib) == std_lib then
		local clients = vim.lsp.get_clients({ name = "gopls" })
		if #clients > 0 then
			return clients[#clients].config.root_dir
		end
	end
	return vim.fs.root(fname, "go.work") or vim.fs.root(fname, "go.mod") or vim.fs.root(fname, ".git")
end

return {
	-- Mason tooling for Go
	{
		"williamboman/mason-lspconfig.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "gopls" })
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "gofumpt", "goimports", "golangci-lint" })
		end,
	},

	-- Treesitter parsers for Go
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "go", "gomod", "gowork", "gotmpl" })
		end,
	},

	-- LSP setup for Go (gopls)
	{
		"neovim/nvim-lspconfig",
		opts = function()
			vim.lsp.config("gopls", {
				cmd = { "gopls" },
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
				root_dir = function(bufnr, on_dir)
					local fname = vim.api.nvim_buf_get_name(bufnr)
					get_mod_cache_dir()
					get_std_lib_dir()
					on_dir(get_root_dir(fname))
				end,
				settings = {
					gopls = {
						semanticTokens = true,
					},
				},
			})
			vim.lsp.enable("gopls")
		end,
	},

	-- Formatter for Go
	{
		"stevearc/conform.nvim",
		opts = function(_, opts)
			opts.formatters_by_ft = opts.formatters_by_ft or {}
			opts.formatters_by_ft.go = { "gofumpt", "goimports" }
		end,
	},

	-- Linter for Go
	{
		"mfussenegger/nvim-lint",
		opts = function(_, opts)
			opts.linters_by_ft = opts.linters_by_ft or {}
			opts.linters_by_ft.go = { "golangcilint" }
		end,
	},

	-- Debugger for Go
	{
		"mfussenegger/nvim-dap",
		dependencies = { "leoluz/nvim-dap-go" },
		opts = function()
			require("dap-go").setup()
		end,
		keys = {
			{
				"<leader>dt",
				function()
					require("dap-go").debug_test()
				end,
				desc = "Debug Test (Go)",
			},
		},
	},
}
