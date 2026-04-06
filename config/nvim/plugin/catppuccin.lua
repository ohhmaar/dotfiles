vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim" },
})

require("catppuccin").setup({
	flavour = "mocha",
	transparent_background = false,
	integrations = {
		blink_cmp = {
			style = "bordered",
		},
		cmp = true,
		gitsigns = true,
		treesitter = true,
		mason = true,
		mini = {
			enabled = true,
			indentscope_color = "mocha",
		},
	},
})

vim.cmd.colorscheme("catppuccin")
