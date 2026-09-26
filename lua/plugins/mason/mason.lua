return {
	"williamboman/mason.nvim",
	cmd = { "Mason", "MasonUpdate", "MasonInstall" },
	build = ":MasonUpdate",
	opts = {
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
		-- Don't check for updates in the background, mason-tool-installer handles installs.
		max_concurrent_installers = 5,
	},
}
