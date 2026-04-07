return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	keys = {
		{
			"<M-l>",
			function()
				require("copilot.suggestion").accept()
			end,
			mode = "i",
			desc = "Accept Copilot suggestion",
		},
	},
	opts = {
		suggestion = {
			enabled = true,
			auto_trigger = true,
			trigger_on_accept = true,
			keymap = { accept = false },
		},
	},
}
