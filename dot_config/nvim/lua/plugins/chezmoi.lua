local pick_chezmoi = function()
	local results = require("chezmoi.commands").list({
		args = {
			"--path-style",
			"absolute",
			"--include",
			"files",
			"--exclude",
			"externals",
		},
	})

	local items = {}

	for _, czFile in ipairs(results) do
		table.insert(items, {
			text = czFile,
			file = czFile,
		})
	end

	---@type snacks.picker.Config
	local opts = {
		items = items,
		confirm = function(picker, item)
			picker:close()
			require("chezmoi.commands").edit({
				targets = { item.text },
				args = { "--watch" },
			})
		end,
	}
	Snacks.picker.pick(opts)
end

return {
	{
		"xvzc/chezmoi.nvim",
		cmd = { "ChezmoiEdit" },
		keys = {
			{
				"<leader>fc",
				pick_chezmoi,
				desc = "Chezmoi",
			},
		},
		opts = {
			edit = {
				watch = false,
				force = false,
			},
			notification = {
				on_open = true,
				on_apply = true,
				on_watch = false,
			},
		},
		init = function()
			-- run chezmoi edit on file enter
			vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
				pattern = { vim.env.HOME .. "/.local/share/chezmoi/*" },
				callback = function()
					vim.schedule(require("chezmoi.commands.__edit").watch)
				end,
			})
		end,
	},
}
