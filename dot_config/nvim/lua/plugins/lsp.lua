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
		opts = {
			ensure_installed = {
				"lua_ls",
				"vue_ls",
				"vtsls",
				"stylua",
				"biome",
				"jsonls",
			},
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		config = function(_, opts)
			require("mason-lspconfig").setup(opts)

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
