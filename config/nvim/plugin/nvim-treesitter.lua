vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

local ensure_installed = {
	"markdown",
	"markdown_inline",
	"vim",
	"make",
	"vimdoc",
	"query",
	"bash",
	"diff",
	"comment",
	"editorconfig",
	"go",
	"git_config",
	"git_rebase",
	"gitattributes",
	"gitcommit",
	"gitignore",
	"javascript",
	"typescript",
	"tsx",
	"jsdoc",
	"yaml",
	"toml",
	"json",
	"lua",
	"luadoc",
	"html",
	"css",
}

require("nvim-treesitter.config").setup({
	ensure_installed = ensure_installed,
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})

local treesitter_filetypes = vim
	.iter(ensure_installed)
	:map(vim.treesitter.language.get_filetypes)
	:flatten()
	:totable()

vim.api.nvim_create_autocmd("FileType", {
	pattern = treesitter_filetypes,
	callback = function(ev)
		vim.treesitter.start(ev.buf)
	end,
})

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(opts)
		if opts.data.spec.name == "nvim-treesitter" and opts.data.kind == "update" then
			vim.cmd("TSUpdate")
		end
	end,
})
