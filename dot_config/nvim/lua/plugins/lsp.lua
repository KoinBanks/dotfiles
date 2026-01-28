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
		version = false,
		opts = {
			ensure_installed = {
				"lua_ls",
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

			vim.lsp.config("vtsls", {
				filetypes = {
					"typescript",
					"javascript",
					"javascriptreact",
					"typescriptreact",
				},
				settings = {
					vtsls = {
						autoUseWorkspaceTsdk = true,
					},
					javascript = {
						suggest = {
							names = false,
							autoImports = false,
						},
					},
				},
			})

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

	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "snacks.nvim", words = { "Snacks" } },
				{ path = "lazy.nvim", words = { "LazyVim" } },
			},
		},
	},
}
