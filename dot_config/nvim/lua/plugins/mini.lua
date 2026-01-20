local ai_buffer = function(ai_type)
	local start_line, end_line = 1, vim.fn.line("$")
	if ai_type == "i" then
		-- Skip first and last blank lines for `i` textobject
		local first_nonblank, last_nonblank =
			vim.fn.nextnonblank(start_line), vim.fn.prevnonblank(end_line)
		-- Do nothing for buffer with all blanks
		if first_nonblank == 0 or last_nonblank == 0 then
			return { from = { line = start_line, col = 1 } }
		end
		start_line, end_line = first_nonblank, last_nonblank
	end

	local to_col = math.max(vim.fn.getline(end_line):len(), 1)
	return {
		from = { line = start_line, col = 1 },
		to = { line = end_line, col = to_col },
	}
end

return {
	{
		"nvim-mini/mini.icons",
		version = false,
		lazy = false,
		priority = 10000,
		opts = {},
		config = function(_, opts)
			local MiniIcons = require("mini.icons")

			MiniIcons.setup(opts)
			MiniIcons.mock_nvim_web_devicons()
		end,
	},

	{
		"nvim-mini/mini.hipatterns",
		version = false,
		config = function()
			local hipatterns = require("mini.hipatterns")
			hipatterns.setup({
				highlighters = {
					fixme = {
						pattern = "%f[%w]()FIXME()%f[%W]",
						group = "MiniHipatternsFixme",
					},
					hack = {
						pattern = "%f[%w]()HACK()%f[%W]",
						group = "MiniHipatternsHack",
					},
					todo = {
						pattern = "%f[%w]()TODO()%f[%W]",
						group = "MiniHipatternsTodo",
					},
					note = {
						pattern = "%f[%w]()NOTE()%f[%W]",
						group = "MiniHipatternsNote",
					},
					hex_color = hipatterns.gen_highlighter.hex_color(),
				},
			})
		end,
	},

	{
		"nvim-mini/mini.ai",
		version = false,
		event = "VeryLazy",
		opts = function()
			local ai = require("mini.ai")
			return {
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({ -- code block
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}),
					f = ai.gen_spec.treesitter({
						a = "@function.outer",
						i = "@function.inner",
					}), -- function
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
					t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
					d = { "%f[%d]%d+" }, -- digits
					e = { -- Word with case
						{
							"%u[%l%d]+%f[^%l%d]",
							"%f[%S][%l%d]+%f[^%l%d]",
							"%f[%P][%l%d]+%f[^%l%d]",
							"^[%l%d]+%f[^%l%d]",
						},
						"^().*()$",
					},
					g = ai_buffer, -- buffer
					u = ai.gen_spec.function_call(), -- u for "Usage"
					U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
				},
			}
		end,
		config = function(_, opts)
			require("mini.ai").setup(opts)
		end,
	},

	{
		"nvim-mini/mini.surround",
		event = "VeryLazy",
		version = false,
		opts = {
			mappings = {
				add = "gsa", -- Add surrounding in Normal and Visual modes
				delete = "gsd", -- Delete surrounding
				find = "gsf", -- Find surrounding (to the right)
				find_left = "gsF", -- Find surrounding (to the left)
				highlight = "gsh", -- Highlight surrounding
				replace = "gsr", -- Replace surrounding
				update_n_lines = "gsn", -- Update `n_lines`
			},
		},
	},

	{ "nvim-mini/mini.pairs", version = false, opts = {}, enabled = false },

	{
		"nvim-mini/mini.comment",
		event = "VeryLazy",
		version = false,
		opts = {},
	},

	{
		"nvim-mini/mini.diff",
		event = "VeryLazy",
		version = false,
		opts = {
			view = {
				style = "number",
				signs = {
					add = "▎",
					change = "▎",
					delete = "",
				},
			},
		},
	},
}
