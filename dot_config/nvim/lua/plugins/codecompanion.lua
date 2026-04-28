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
								-- handlers = {
								-- 	response = {
								-- 		---@param self CodeCompanion.HTTPAdapter
								-- 		--- `data` is the output of the `parse_chat` handler
								-- 		---@param data {status: string, output: {role: string?, content: string?}, extra: table}
								-- 		---@return {status: string, output: {role: string?, content: string?, reasoning:{content: string?}?}}
								-- 		parse_meta = function(self, data)
								-- 			local extra = data.extra
								-- 			if extra.reasoning_content then
								-- 				-- codecompanion expect the reasoning tokens in this format
								-- 				data.output.reasoning =
								-- 					{ content = extra.reasoning_content }
								-- 				-- so that codecompanion doesn't mistake this as a normal response with empty string as the content
								-- 				if data.output.content == "" then
								-- 					data.output.content = nil
								-- 				end
								-- 			end
								-- 			return data
								-- 		end,
								-- 	},
								-- },
							}
						)
					end,
				},
			},
		})
	end,
}
