vim.pack.add({
	{ src = "https://github.com/williamboman/mason.nvim" },
})

require("mason").setup({
	ui = {
		border = "single",
	},
})
