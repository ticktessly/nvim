return {
	{
		"zbirenbaum/copilot.lua",
		event = { "InsertEnter" },
		cmd = { "Copilot" },
		opts = {
			server = { type = "nodejs" },
			suggestion = {
				auto_trigger = true,
			},
		},
	},
}
