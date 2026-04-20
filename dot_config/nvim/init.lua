require("config.lazy")

if vim.fn.argc() == 0 then
	require("persistence").load({ last = true })
end
