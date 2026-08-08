return {
	cmd = { "./node_modules/.bin/tsc", "--lsp", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
	},
	root_markers = { "package.json", "tsconfig.json" },
	settings = {},
}
