return {
	-- "iFarmGolems/deploy.nvim",
	dir = "~/develop/repos/deploy.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-neotest/nvim-nio" },
	event = "VeryLazy",
	keys = {
		{
			"<leader>df",
			":Deploy file<CR>",
			desc = "Deploy current file",
			silent = true,
		},
		{
			"<leader>dt",
			":Deploy toggle<CR>",
			desc = "Toggle deploy on save",
			silent = true,
		},
		{
			"<leader>dl",
			":Deploy log<CR>",
			desc = "Toggle deploy on save",
			silent = true,
		},
		{
			"<leader>dp",
			":Deploy package<CR>",
			desc = "Deploy package",
			silent = true,
		},
	},
	config = function()
		require("deploy").setup({
			timeout = 10,
			tool = "rsync",
			packages = {
				{
					label = "GeoSuite",
					globs = {
						"/home/patrik/develop/repos/mis/sw/ims/ims4/Web/src/main/webapp/js2/fragments/geosuite/**.*",
					},
				},
				{
					label = "GeoSuite Build",
					globs = {
						"/home/patrik/develop/repos/mis/sw/ims/ims4/Web/src/main/webapp/build2/dist/**.*",
					},
				},
			},
			hosts = {
				{
					address = "ims@46.224.9.12",
					label = "Hetzner Weather Studio DEV",
					rewrite = function(context)
						local changed_path = context.destination:gsub(
							"/opt/ims/tomcat/webapps/ims",
							"/home/ims/web-deploy"
						)

						context.destination = changed_path
					end,
				},
				{
					address = "10.111.8.26",
					label = "Bosna 1025 DEV",
				},
				{
					address = "172.18.2.24",
					label = "SHMU DEV",
				},
				{
					address = "172.18.1.235",
					label = "Bosna 1025 PROD",
				},
				{
					address = "10.111.9.231",
					label = "Sakhalin 1309 DEV",
				},
				{
					address = "192.168.111.220",
					label = "Kocka",
				},
				{
					address = "10.111.2.42",
					label = "IMSASAN 991 DEV",
				},
				{
					address = "192.168.151.90",
					label = "IMSASAN 991 PROD",
				},
				{
					address = "awos-dev.mstep",
					label = "awos dev",
				},
				{
					address = "139.129.22.177:9090",
					label = "china prod",
				},
			},
			mappings = {
				{
					fs = "/home/patrik/develop/repos/mis/sw/ims/ims4/Web/src/main/webapp",
					remote = "/opt/ims/tomcat/webapps/ims",
					rewrite = function(context)
						local skip_extensions = { "ts", "lock", "sh", "md", "java" }

						if vim.tbl_contains(skip_extensions, context.extension or "") then
							return false
						end
					end,
				},
				{
					fs = "/home/patrik/develop/repos/mis/sw/ims/ims4/Jlib/src/main/resources",
					remote = "/opt/ims/bin",
				},
				{
					fs = "/home/patrik/.local/share/chezmoi/scripts",
					remote = "/home/ims/scripts",
				},
			},
		})
	end,
}
