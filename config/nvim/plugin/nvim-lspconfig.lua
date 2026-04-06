vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
})

vim.lsp.enable({
	"gopls",
	"lua_ls",
	"ts_ls",
	"terraformls",
})
