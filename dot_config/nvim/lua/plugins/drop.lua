return {
	"folke/drop.nvim",
	enabled = function()
		return vim.g.AT_WORK
	end,
	opts = {
		screensaver = 1000 * 60 * 2,
	},
}
