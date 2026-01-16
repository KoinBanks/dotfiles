return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
	version = "1.*",
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = { preset = "enter", ["<C-y>"] = { "select_and_accept" } },
		appearance = {
			nerd_font_variant = "mono",
		},
		cmdline = {
			enabled = false,
		},
		completion = {
			documentation = { auto_show = true, auto_show_delay_ms = 200 },
			ghost_text = { enabled = false },
			accept = { auto_brackets = { enabled = false } },
			menu = {
				direction_priority = { "n", "s" },
				draw = {
					components = {
						kind_icon = {
							text = function(ctx)
								local kind_icon, _, _ =
									require("mini.icons").get("lsp", ctx.kind)
								return kind_icon
							end,
							highlight = function(ctx)
								local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
								return hl
							end,
						},
						kind = {
							highlight = function(ctx)
								local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
								return hl
							end,
						},
					},
				},
			},
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			per_filetype = {
				javascript = { "lsp", "path", "snippets" },
				codecompanion = { "codecompanion" },
				["grug-far"] = {},
			},
			providers = {
				snippets = {
					opts = {
						friendly_snippets = false,
					},
				},
			},
		},
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
