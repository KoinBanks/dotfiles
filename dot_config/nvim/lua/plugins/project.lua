return {
	"ahmedkhalf/project.nvim",
	config = function()
		require("project_nvim").setup({
			manual_mode = false,
			silent_chdir = true,
			detection_methods = { "pattern" },
			patterns = {
				"!^node_modules",
				"package.json",
				"tsconfig.json",
				"jsconfig.json",
				".git",
			},
		})
	end,
}
