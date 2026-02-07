return {
	dir = "~/develop/repos/spear.nvim",
	config = function()
		require("spear").setup({
			prune_missing = true,
		})
	end,
	keys = function()
		local spear = require("spear")

		local keys = {
			{
				"<leader>H",
				function()
					spear.add_file()
				end,
				desc = "Spear Add File",
			},
			{
				"<leader>h",
				function()
					spear.toggle()
				end,
				desc = "Spear List",
			},
		}

		for i = 1, 9 do
			table.insert(keys, {
				"<leader>" .. i,
				function()
					spear.open_file(i)
				end,
				desc = "Spear to file #" .. i,
			})
		end

		return keys
	end,
}
