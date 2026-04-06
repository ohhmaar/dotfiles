vim.pack.add({
	{ src = "https://github.com/nvim-mini/mini.nvim" },
})

require("mini.git").setup()
require("mini.diff").setup({
	view = {
		style = "sign",
		signs = { add = "+", change = "~", delete = "_" },
	},
})
require("mini.notify").setup()

local miniclue = require("mini.clue")
miniclue.setup({
	triggers = {
		{ mode = "n", keys = "<Leader>" },
		{ mode = "x", keys = "<Leader>" },
		{ mode = "i", keys = "<C-x>" },
		{ mode = "n", keys = "g" },
		{ mode = "x", keys = "g" },
		{ mode = "n", keys = "'" },
		{ mode = "n", keys = "`" },
		{ mode = "x", keys = "'" },
		{ mode = "x", keys = "`" },
		{ mode = "n", keys = '"' },
		{ mode = "x", keys = '"' },
		{ mode = "i", keys = "<C-r>" },
		{ mode = "c", keys = "<C-r>" },
		{ mode = "n", keys = "<C-w>" },
		{ mode = "n", keys = "z" },
		{ mode = "x", keys = "z" },
	},
	clues = {
		miniclue.gen_clues.builtin_completion(),
		miniclue.gen_clues.g(),
		miniclue.gen_clues.marks(),
		miniclue.gen_clues.registers(),
		miniclue.gen_clues.windows(),
		miniclue.gen_clues.z(),
	},
})

require("mini.pick").setup({
	mappings = {
		choose_all = {
			char = "<C-q>",
			func = function()
				local pick = require("mini.pick")
				local mappings = pick.get_picker_opts().mappings
				vim.api.nvim_input(mappings.mark_all .. mappings.choose_marked)
			end,
		},
	},
})

require("mini.ai").setup({ n_lines = 500 })
require("mini.move").setup()
require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.comment").setup({})
