vim.keymap.set(
	"n",
	"x",
	'"_x',
	{ desc = "Delete character without storing it in register" }
)

vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode" })

vim.keymap.set(
	{ "i", "n" },
	",,",
	"<Esc>A,<CR>",
	{ desc = "Insert comma at the end of a row and add a newline" }
)

vim.keymap.set(
	"n",
	"<M-o>",
	":SwitchIMSFileType<CR>",
	{ silent = true, desc = "Switch IMS page files" }
)

vim.keymap.set(
	"i",
	"<C-v>",
	"<C-r>+",
	{ desc = "Paste from clipboard in insert mode" }
)

vim.keymap.set(
	"n",
	"<leader>fi",
	":FindIMSPath<CR>",
	{ silent = true, desc = "Find IMS path" }
)

vim.keymap.set(
	"n",
	"<leader>oi",
	":OpenBranchTask<CR>",
	{ silent = true, desc = "Open branch task in browser" }
)
