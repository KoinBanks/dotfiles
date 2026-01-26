return {
	"enochchau/nvim-pretty-ts-errors",
	build = "npm install",
	keys = {
		{
			"<leader>t",
			function()
				require("nvim-pretty-ts-errors").show_line_diagnostics()
			end,
			desc = "Show pretty TypeScript errors",
		},
	},
}
