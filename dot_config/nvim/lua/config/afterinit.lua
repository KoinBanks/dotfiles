-- restore last session if no files were specified on the command line
if vim.fn.argc() == 0 then
	require("persistence").load({ last = true })
end

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

-- cache the Windows home directory path in a global variable for use in other parts of the configuration
vim.system({ "wslupath", "-H" }, function(res)
	if res.code == 0 then
		vim.g.__windows_home_dir = res.stdout:gsub("\n", "")
	else
		print("Error getting wslupath home: " .. res.stderr)
	end
end)
