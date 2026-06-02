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
					adapter = { name = "deepseek", model = "deepseek-v4-pro" },
					opts = {
						completion_provider = "blink",
					},
				},
				inline = {
					adapter = { name = "copilot_fix", model = "gpt-5.4-mini" },
				},
				background = {
					adapter = {
						name = "copilot_acp",
						model = "gpt-5.4-mini",
					},
				},
			},
			adapters = {
				http = {
					opts = { show_presets = false },
					copilot_fix = function()
						return require("codecompanion.adapters").extend("copilot", {
							schema = {
								top_p = {
									enabled = function()
										return false
									end,
								},
							},
						})
					end,
					deepseek = function()
						return require("codecompanion.adapters").extend("deepseek", {
							schema = {
								model = {
									default = "deepseek-v4-pro",
								},
							},
						})
					end,
					openrouter = function()
						return require("codecompanion.adapters").extend(
							"openai_compatible",
							{
								env = {
									url = "https://openrouter.ai/api",
									api_key = vim.env.OPENROUTER_API_KEY,
									chat_url = "/v1/chat/completions",
								},
								schema = {
									model = {
										default = "deepseek/deepseek-v4-flash",
									},
								},
							}
						)
					end,
				},
			},
		})
	end,
}
