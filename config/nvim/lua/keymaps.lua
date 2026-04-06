local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

map("i", "jj", "<ESC>")
map("i", "jk", "<ESC>")

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

map("n", "<leader>gg", function()
	local buf = vim.api.nvim_create_buf(false, true)
	local width = math.floor(vim.o.columns * 0.9)
	local height = math.floor(vim.o.lines * 0.9)
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		col = math.floor((vim.o.columns - width) / 2),
		row = math.floor((vim.o.lines - height) / 2),
		style = "minimal",
		border = "rounded",
	})
	vim.fn.termopen("lazygit", {
		on_exit = function()
			vim.api.nvim_win_close(win, true)
		end,
	})
	vim.cmd("startinsert")
end, { desc = "Lazygit" })

map("n", "<leader>e", ":Oil<CR>", { desc = "Oil" })

map("n", "<leader>cf", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format buffer" })

map("n", "<leader>tf", function()
	vim.g.disable_autoformat = not vim.g.disable_autoformat
	if vim.g.disable_autoformat then
		vim.notify("Format-on-save disabled", vim.log.levels.INFO)
	else
		vim.notify("Format-on-save enabled", vim.log.levels.INFO)
	end
end, { desc = "Toggle format-on-save" })

map("n", "<leader>ff", function()
	require("mini.pick").builtin.files()
end, { desc = "Find files" })
map("n", "<leader>/", function()
	require("mini.pick").builtin.grep_live()
end, { desc = "Grep (live)" })
map("n", "<leader>fr", function()
	require("mini.pick").start({ source = { items = vim.v.oldfiles, name = "Oldfiles" } })
end, { desc = "Find recent files" })
map("n", "<leader><leader>", function()
	require("mini.pick").builtin.buffers()
end, { desc = "Find buffers" })
map("n", "<leader>fh", function()
	require("mini.pick").builtin.help()
end, { desc = "Find help" })
map("n", "<leader>fl", function()
	require("mini.pick").builtin.resume()
end, { desc = "Resume last picker" })
map("n", "<leader>fw", function()
	local word = vim.fn.expand("<cword>")
	require("mini.pick").builtin.grep({ pattern = word })
end, { desc = "Find word under cursor" })
map("n", "<leader>fg", function()
	require("mini.pick").builtin.files({ tool = "git" })
end, { desc = "Find git files" })
