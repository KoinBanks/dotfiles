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
		vim.opt_local.colorcolumn = "81"
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

local spinner =
	{ "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }

local cc_group =
	vim.api.nvim_create_augroup("CodeCompanionFidgetHooks", { clear = true })

vim.api.nvim_create_autocmd({ "User" }, {
	pattern = "CodeCompanion*",
	group = cc_group,
	callback = function(request)
		if request.match == "CodeCompanionChatSubmitted" then
			return
		end

		local msg

		msg = "[CodeCompanion] " .. request.match:gsub("CodeCompanion", "")

		Snacks.notifier.notify(msg, vim.log.levels.INFO, {
			timeout = 3000,
			id = "code_companion_status",
			title = "Code Companion Status",
			opts = function(notif)
				notif.icon = ""
				if vim.endswith(request.match, "Started") then
					---@diagnostic disable-next-line: undefined-field
					notif.icon =
						spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
				elseif vim.endswith(request.match, "Finished") then
					notif.icon = " "
				end
			end,
		})
	end,
})
