local function augroup(name)
	return vim.api.nvim_create_augroup("ifarmgolems_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("FileType", {
	group = augroup("colorcolumn_js_ts"),
	pattern = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"lua",
	},
	callback = function()
		vim.opt_local.colorcolumn = "101"
	end,
})

-- Go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup("last_loc"),
	callback = function(event)
		local exclude = { "gitcommit" }
		local buf = event.buf
		if
			vim.tbl_contains(exclude, vim.bo[buf].filetype)
			or vim.b[buf].ifarmgolems_saved_last_loc
		then
			return
		end
		vim.b[buf].ifarmgolems_saved_last_loc = true
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"codecompanion",
		"PlenaryTestPopup",
		"checkhealth",
		"dbout",
		"gitsigns-blame",
		"grug-far",
		"help",
		"lspinfo",
		"neotest-output",
		"neotest-output-panel",
		"neotest-summary",
		"notify",
		"qf",
		"spectre_panel",
		"startuptime",
		"tsplayground",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.schedule(function()
			vim.keymap.set("n", "q", function()
				vim.cmd("close")
				pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
			end, {
				buffer = event.buf,
				silent = true,
				desc = "Quit buffer",
			})
		end)
	end,
})

-- Automatically apply chezmoi changes on save
local chezmoi_pattern = os.getenv("HOME") .. "/.local/share/chezmoi/*"
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = chezmoi_pattern,
	callback = function()
		local file = vim.fn.expand("%:p")
		local is_winhome = file:find("/winhome/")

		if not is_winhome then
			vim.system({ "chezmoi", "apply", "--source-path", file }, {
				cwd = os.getenv("HOME"),
			}, function(result)
				if result.code == 0 then
					vim.schedule(function()
						vim.notify("Successfully applied!", vim.log.levels.INFO, {
							title = "Chezmoi",
						})
					end)
				else
					vim.schedule(function()
						vim.notify(
							"Failed to apply " .. file .. " with chezmoi: " .. result.stderr,
							vim.log.levels.ERROR,
							{
								title = "Chezmoi",
							}
						)
					end)
				end
			end)
		end
	end,
})
