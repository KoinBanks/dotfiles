return {
	"olimorris/codecompanion.nvim",
	version = "^19.0.0",
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
					adapter = { name = "copilot_fix", model = "gpt-5.4" },
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
					openrouter = function()
						return require("codecompanion.adapters").extend(
							"openai_compatible",
							{
								env = {
									url = "https://openrouter.ai/api",
									api_key = "OPENROUTER_API_KEY",
									chat_url = "/v1/chat/completions",
								},
								handlers = {
									parse_message_meta = function(_, data)
										local extra = data.extra
										if extra and extra.reasoning then
											data.output.reasoning = { content = extra.reasoning }
											if data.output.content == "" then
												data.output.content = nil
											end
										end
										return data
									end,
								},
								schema = {
									model = {
										default = "deepseek/deepseek-v3.2-speciale",
										choices = {
											["deepseek/deepseek-v3.2-speciale"] = {},
											["deepseek/deepseek-v3.2"] = {},
											["openai/gpt-5.2"] = {},
											["minimax/minimax-m2.1"] = {},
											["google/gemini-3-flash-preview"] = {},
											["z-ai/glm-4.7"] = {},
										},
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
