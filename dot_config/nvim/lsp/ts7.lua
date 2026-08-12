return {
	cmd = { "./node_modules/.bin/tsc", "--lsp", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
	},
	root_dir = function(bufnr, on_dir)
		local root = vim.fs.root(bufnr, { "package.json", "tsconfig.json" })
		if not root then
			return
		end

		local tsc = vim.fs.joinpath(root, "node_modules", ".bin", "tsc")
		if vim.fn.executable(tsc) ~= 1 then
			return
		end

		-- ponytail: only local TS7; hoisted/global installs stay out.
		vim.system({ tsc, "--version" }, { text = true }, function(result)
			if result.code == 0 and (result.stdout or ""):match("Version%s+7%.") then
				on_dir(root)
			end
		end)
	end,
	settings = {},
}
