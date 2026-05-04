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

require("mini.files").setup({
	mappings = {
		close = "<Esc>",
		go_in = "<CR>", -- Map both Enter and L to enter directories or open files
		go_in_plus = "L",
		go_out = "-",
		go_out_plus = "H",
	},
})
vim.keymap.set("n", "<leader>ee", "<cmd>lua MiniFiles.open()<CR>", { desc = "Toggle mini file explorer" }) -- toggle file explorer
vim.keymap.set("n", "<leader>ef", function()
	local files = require("mini.files")
	files.open(vim.api.nvim_buf_get_name(0), false)
	files.reveal_cwd()
end, { desc = "Toggle into currently opened file" })
require("mini.ai").setup({ n_lines = 500 })
require("mini.move").setup()
require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.comment").setup({})
