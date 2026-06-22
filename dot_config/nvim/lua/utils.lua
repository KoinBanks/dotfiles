local M = {}

M.load_json = function(path)
	local text = table.concat(vim.fn.readfile(path), "\n")
	return vim.json.decode(text)
end

return M
