return {
	"olimorris/codecompanion.nvim",
	-- dir = "~/develop/repos/codecompanion.nvim",
	-- dev = true,
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
					adapter = { name = "copilot", model = "gpt-5.6-luna" },
					opts = {
						completion_provider = "blink",
					},
					tools = {
						["read_file"] = {
							opts = {
								require_approval_before = false,
							},
						},
					},
				},
				inline = {
					adapter = { name = "copilot", model = "gpt-5.6-luna" },
				},
			},
			-- adapters = {
			-- 	http = {
			-- 		copilot_fix = function()
			-- 			return require("codecompanion.adapters").extend("copilot", {
			-- 				schema = {
			-- 					top_p = {
			-- 						enabled = function()
			-- 							return false
			-- 						end,
			-- 					},
			-- 				},
			-- 			})
			-- 		end,
			-- 	},
			-- },
		})
	end,
}
