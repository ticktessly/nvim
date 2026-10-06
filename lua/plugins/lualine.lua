local icons = {
	diagnostics = { Error = " ", Warn = " ", Hint = " ", Info = " " },
	git = { added = " ", modified = " ", removed = " " },
}

local function hl_fg(name)
	local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name })
	if ok and hl.fg then
		return string.format("#%06x", hl.fg)
	end
	return nil
end

local function pretty_path()
	return function()
		local path = vim.fn.expand("%:p")
		if path == "" then
			return ""
		end
		local cwd = vim.fn.getcwd()
		if path:find(cwd, 1, true) == 1 then
			path = path:sub(#cwd + 2)
		end
		local parts = vim.split(path, "[\\/]")
		if #parts > 3 then
			parts = { parts[1], "…", unpack(parts, #parts - 1, #parts) }
		end
		local dir = ""
		if #parts > 1 then
			dir = table.concat({ unpack(parts, 1, #parts - 1) }, "/") .. "/"
		end
		return dir .. parts[#parts] .. (vim.bo.readonly and " 󰌾 " or "")
	end
end

return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	init = function()
		vim.g.lualine_laststatus = vim.o.laststatus
		if vim.fn.argc(-1) > 0 then
			vim.o.statusline = " "
		else
			vim.o.laststatus = 0
		end
	end,
	opts = function()
		local lualine_require = require("lualine_require")
		lualine_require.require = require

		vim.o.laststatus = vim.g.lualine_laststatus

		return {
			options = {
				theme = "auto",
				globalstatus = vim.o.laststatus == 3,
				disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },
				lualine_c = {
					{
						function()
							return vim.fs.basename(vim.fn.getcwd())
						end,
						color = function()
							return { fg = hl_fg("Special") }
						end,
					},
					{
						"diagnostics",
						symbols = {
							error = icons.diagnostics.Error,
							warn = icons.diagnostics.Warn,
							info = icons.diagnostics.Info,
							hint = icons.diagnostics.Hint,
						},
					},
					{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
					{ pretty_path() },
				},
				lualine_x = {
					{
						function()
							return require("noice").api.status.command.get()
						end,
						cond = function()
							return package.loaded["noice"] and require("noice").api.status.command.has()
						end,
						color = function()
							return { fg = hl_fg("Statement") }
						end,
					},
					{
						function()
							return require("noice").api.status.mode.get()
						end,
						cond = function()
							return package.loaded["noice"] and require("noice").api.status.mode.has()
						end,
						color = function()
							return { fg = hl_fg("Constant") }
						end,
					},
					{
						require("lazy.status").updates,
						cond = require("lazy.status").has_updates,
						color = function()
							return { fg = hl_fg("Special") }
						end,
					},
					{
						"diff",
						symbols = {
							added = icons.git.added,
							modified = icons.git.modified,
							removed = icons.git.removed,
						},
					},
				},
				lualine_y = {
					{ "progress", separator = " ", padding = { left = 1, right = 0 } },
					{ "location", padding = { left = 0, right = 1 } },
				},
				lualine_z = {
					function()
						return " " .. os.date("%R")
					end,
				},
			},
			extensions = { "lazy", "fzf" },
		}
	end,
}
