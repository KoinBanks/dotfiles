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
				"editorconfig",
				"java",
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
				automatic_enable = {
					exclude = {
						"oxfmt",
					},
				},
				ensure_installed = {
					"oxlint",
					"oxfmt",
					"html",
					"lua_ls",
					"fish_lsp",
					"stylua",
					"jsonls",
					-- "vtsls",
				},
			})

			vim.lsp.config("lua_ls", {
				---@type lspconfig.settings.lua_ls
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

			vim.lsp.config("tsrs", {
				cmd = { "tsrs", "--lsp", "-stdio" },
				filetypes = {
					"typescript",
					"typescriptreact",
					"javascript",
					"javascriptreact",
				},
				root_markers = {
					"tsconfig.json",
					"jsconfig.json",
					"package.json",
				},
			})

			vim.lsp.enable("tsrs")

			-- local ts_filetypes = {
			-- 	"typescript",
			-- 	"javascript",
			-- 	"javascriptreact",
			-- 	"typescriptreact",
			-- 	"vue",
			-- }

			-- local vue_plugin = {
			-- 	name = "@vue/typescript-plugin",
			-- 	location = vue_language_server_path,
			-- 	languages = { "vue" },
			-- 	configNamespace = "typescript",
			-- }

			-- vim.lsp.config("vtsls", {
			-- 	filetypes = ts_filetypes,
			-- 	root_dir = function(bufnr, on_dir)
			-- 		local root_markers = {
			-- 			"package.json",
			-- 			"bunfig.toml",
			-- 		}
			--
			-- 		local project_root = vim.fs.root(bufnr, root_markers)
			--
			-- 		on_dir(project_root or vim.fn.getcwd())
			-- 	end,
			-- 	---@type lspconfig.settings.vtsls
			-- 	settings = {
			-- 		vtsls = {
			-- 			autoUseWorkspaceTsdk = true,
			-- 			experimental = {
			-- 				completion = {
			-- 					enableServerSideFuzzyMatch = true,
			-- 				},
			-- 			},
			-- 			-- tsserver = {
			-- 			-- 	globalPlugins = {
			-- 			-- 		vue_plugin,
			-- 			-- 	},
			-- 			-- },
			-- 		},
			-- 		javascript = {
			-- 			suggest = {
			-- 				names = false,
			-- 				autoImports = false,
			-- 			},
			-- 		},
			-- 	},
			-- })
		end,
	},
}
