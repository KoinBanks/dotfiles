return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		version = false, -- last release is way too old
		build = ":TSUpdate",
		lazy = false,
		config = function()
			local TS = require("nvim-treesitter")

			require("nvim-treesitter").setup()

			TS.install({
				"javascript",
				"typescript",
				"xml",
				"vue",
				"jsdoc",
				"lua",
				"luadoc",
				"json",
				"jsonc",
				"tsx",
				"css",
				"scss",
				"fish",
				"html",
				"vim",
				"markdown",
				"markdown_inline",
				"bash",
				"yaml",
				"toml",
				"regex",
			})
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"html",
					"lua_ls@3.16.4",
					"vue_ls",
					"fish_lsp",
					"vtsls",
					"stylua",
					"biome",
					"jsonls",
				},
			})

			local vue_language_server_path = vim.fn.expand("$MASON/packages")
				.. "/vue-language-server"
				.. "/node_modules/@vue/language-server"

			local ts_filetypes = {
				"typescript",
				"javascript",
				"javascriptreact",
				"typescriptreact",
				"vue",
			}

			local vue_plugin = {
				name = "@vue/typescript-plugin",
				location = vue_language_server_path,
				languages = { "vue" },
				configNamespace = "typescript",
			}

			vim.lsp.config("vtsls", {
				filetypes = ts_filetypes,
				settings = {
					vtsls = {
						tsserver = {
							globalPlugins = {
								vue_plugin,
							},
						},
					},
					javascript = {
						suggest = {
							names = false,
							autoImports = false,
						},
					},
				},
			})

			vim.lsp.config("vue_ls", {})

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						workspace = {
							checkThirdParty = false,
						},
						codeLens = {
							enable = true,
						},
						completion = {
							callSnippet = "Replace",
						},
						doc = {
							privateName = { "^_" },
						},
						hint = {
							enable = true,
							setType = false,
							paramType = true,
							paramName = "Disable",
							semicolon = "Disable",
							arrayIndex = "Disable",
						},
					},
				},
			})
		end,
	},
}
