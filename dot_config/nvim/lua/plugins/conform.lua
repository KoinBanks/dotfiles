return {
	"stevearc/conform.nvim",
	event = "BufReadPre",
	opts = {
		formatters = {
			biome = {
				require_cwd = true,
			},
			injected = { options = { ignore_errors = true } },
		},
		format_on_save = {
			timeout_ms = 500,
		},
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { "biome" },
			typescript = { "biome" },
			json = { "prettierd" },
			markdown = { "prettierd" },
			html = { "prettierd" },
			css = { "prettierd" },
			yaml = { "prettierd" },
			vue = { "biome" },
		},
	},
	keys = {
		{
			"<leader>cF",
			function()
				require("conform").format({
					formatters = { "injected" },
					timeout_ms = 3000,
				})
			end,
			mode = { "n", "v" },
			desc = "Format Injected Langs",
		},
	},
}
