---
name: vimdoc
description: Pulls neovim documentation
disable-model-invocation: true
argument-hint: [help-tag]
---

Use the following command to obtain neovim documentation for the help tag: 
`nvim --headless +'help <help-tag>' +'lua io.write(table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n"))' +qa`
