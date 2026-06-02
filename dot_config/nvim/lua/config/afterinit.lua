-- cache the list of files managed by chezmoi in a global variable
vim.system({
	"chezmoi",
	"managed",
	"--path-style",
	"source-absolute",
	"--include",
	"files",
}, function(res)
	if res.code == 0 then
		vim.g.__chezmoi_files = vim.split(res.stdout, "\n", { trimempty = true })
	else
		print("Error getting chezmoi files: " .. res.stderr)
	end
end)
