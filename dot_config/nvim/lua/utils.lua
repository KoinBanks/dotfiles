local M = {}

M.load_json = function(path)
	if vim.uv.fs_stat(path) == nil then
		return {}
	end

	local text = table.concat(vim.fn.readfile(path), "\n")
	return vim.json.decode(text)
end

return M
