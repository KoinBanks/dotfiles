local theme = "gruvbox"

return {
	{
		"ellisonleao/gruvbox.nvim",
		enabled = theme == "gruvbox",
		branch = "main",
		version = false,
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				dim_inactive = false,
				transparent_mode = false,
				contrast = "hard",
				italic = {
					strings = false,
					emphasis = true,
					comments = false,
					operators = true,
					folds = true,
				},
				undercurl = true,
				underline = true,
				-- terminal_colors = true, -- add neovim terminal colors
				-- undercurl = true,
				-- underline = true,
				-- bold = true,
				-- strikethrough = true,
				-- invert_selection = false,
				-- invert_signs = false,
				-- invert_tabline = false,
				-- invert_intend_guides = false,
				-- inverse = true, -- invert background for search, diffs, statuslines and errors
				-- contrast = "hard", -- can be "hard", "soft" or empty string
				-- palette_overrides = {},
				-- overrides = {},
				-- dim_inactive = false,
				-- transparent_mode = false,
			})

			vim.cmd.colorscheme("gruvbox")
		end,
	},
	{
		"ember-theme/nvim",
		enabled = theme == "ember",
		name = "ember",
		priority = 1000,
		config = function()
			require("ember").setup({
				variant = "ember", -- "ember" | "ember-soft" | "ember-light"
			})

			vim.cmd("colorscheme ember")
		end,
	},
}
