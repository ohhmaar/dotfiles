return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = {
					enable = true,
				},
				ensure_installed = {
					"lua",
					"go",
          "gomod",
          "gosum",
          "gowork"
				},
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = {
			max_lines = 1,
		},
	},
}
