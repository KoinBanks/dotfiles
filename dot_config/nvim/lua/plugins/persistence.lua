return {
	"folke/persistence.nvim",
	event = "BufReadPre",
	opts = {
		need = 0,
		branch = false,
	},
	keys = {
		{
			"<leader>qs",
			function()
				require("persistence").load()
			end,
			desc = "Restore Session",
		},
	},
}
