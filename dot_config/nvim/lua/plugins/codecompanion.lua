return {
	"olimorris/codecompanion.nvim",
	branch = "main",
	enabled = true,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	keys = {
		{
			"<C-a>",
			":CodeCompanion ",
			mode = { "v" },
			desc = "Code Companion inline edit",
		},
		{
			"<leader>aa",
			":CodeCompanionChat Toggle<CR>",
			mode = { "n" },
			silent = true,
			desc = "Code Companion Chat",
		},
		{
			"<leader>ac",
			":CodeCompanionActions<CR>",
			mode = { "n" },
			silent = true,
			desc = "Code Companion Actions",
		},
	},
	config = function()
		require("codecompanion").setup({
			opts = {
				log_level = "DEBUG",
			},
			rules = {
				default = {
					description = "Default rules",
					files = {
						"~/.agents/skills/caveman/SKILL.md",
						"AGENTS.md",
						"PERSONAL.md",
					},
				},
				opts = {
					chat = {
						autoload = "default",
						enabled = true,
					},
				},
			},
			interactions = {
				chat = {
					adapter = { name = "copilot", model = "gpt-5.4-mini" },
					opts = {
						completion_provider = "blink",
					},
				},
				inline = {
					adapter = { name = "copilot", model = "gpt-5.4-mini" },
				},
			},
		})
	end,
}
