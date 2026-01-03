vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

vim.opt.winborder = "rounded"
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.swapfile = false
vim.o.cursorline = true
vim.o.cursorcolumn = false
vim.o.ignorecase = true
vim.o.shiftwidth = 2
vim.o.termguicolors = true
vim.o.undofile = true
vim.o.incsearch = true
vim.o.signcolumn = "yes"
vim.o.clipboard = "unnamedplus"
vim.o.autoread = true
vim.o.mouse = "a"

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Exit on jj and jk
vim.keymap.set("i", "jj", "<ESC>")
vim.keymap.set("i", "jk", "<ESC>")

-- Move selected lines up/down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Lazygit floating terminal
vim.keymap.set("n", "<leader>gg", function()
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

vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/williamboman/mason.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/catppuccin/nvim" },
	{ src = "https://github.com/saghen/blink.cmp", version = "v1.8.0" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-mini/mini.nvim" },
	{ src = "https://github.com/fatih/vim-go" },
})

-- INFO: treesitter
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
-- require("nvim-treesitter").install(ensure_installed)

local filetypes = vim.iter(ensure_installed):map(vim.treesitter.language.get_filetypes):flatten():totable()
-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Return to last position
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})
-- Enable treesitter for all installed languages
vim.api.nvim_create_autocmd("FileType", {
	pattern = filetypes,
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

-- INFO: mason
require("mason").setup({})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("my.lsp", {}),
	callback = function(args)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf, desc = "Go to definition" })
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = args.buf, desc = "Go to implementation" })
		vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = args.buf, desc = "References" })
		vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = args.buf, desc = "Type definition" })

		-- Refactoring
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = args.buf, desc = "Rename symbol" })

		-- Diagnostics (native vim.diagnostic)
		vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>", { desc = "Quickfix next" })
		vim.keymap.set("n", "<M-k>", "<cmd>cprevious<CR>", { desc = "Quickfix previous" })

		vim.keymap.set("n", "gl", vim.diagnostic.open_float, { buffer = args.buf, desc = "Show diagnostic" })
		vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { buffer = args.buf, desc = "Diagnostic list" })
		vim.keymap.set(
			"n",
			"<leader>dq",
			vim.diagnostic.setqflist,
			{ buffer = args.buf, desc = "Workspace diagnostics" }
		)
		vim.keymap.set("n", "<leader>cc", "<cmd>cclose<CR>", { desc = "Close quickfix" })
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = args.buf, desc = "Code Action" })
		vim.keymap.set("v", "<leader>ca", vim.lsp.buf.code_action, { buffer = args.buf, desc = "Code Action" })
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		client.server_capabilities.semanticTokensProvider = nil
		if client:supports_method("textDocument/completion") then
			-- Optional: trigger autocompletion on EVERY keypress. May be slow!
			local chars = {}
			for i = 32, 126 do
				table.insert(chars, string.char(i))
			end
			client.server_capabilities.completionProvider.triggerCharacters = chars
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		end
	end,
})

vim.diagnostic.config({
	virtual_text = true,
	underline = true,
	-- float = { border = "rounded" },
})
vim.cmd([[set completeopt+=menuone,noselect,popup]])

vim.lsp.enable({
	"gopls",
	"lua_ls",
	"ts_ls",
	"terraformls",
})

-- INFO: oil

require("oil").setup({
	default_file_explorer = true,
	view_options = { show_hidden = true },
})

vim.keymap.set("n", "<leader>e", ":Oil<CR>", { desc = "Oil" })
-- INFO: blink

require("blink.cmp").setup({
	keymap = { preset = "default" },
	appearance = {
		nerd_font_variant = "mono",
	},
	completion = { documentation = { auto_show = true } },
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	fuzzy = { implementation = "prefer_rust", prebuilt_binaries = {
		force_version = "v1.8.0",
	} },
})
-- INFO: conform

require("conform").setup({
	notify_on_error = false,
	format_on_save = function(bufnr)
		-- Check if format-on-save is disabled globally or for this buffer
		if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
			return nil
		end

		-- Skip formatting for specific filetypes
		local disable_filetypes = { c = true, cpp = true }
		if disable_filetypes[vim.bo[bufnr].filetype] then
			return nil
		end

		return { timeout_ms = 500, lsp_format = "fallback" }
	end,
	formatters_by_ft = {
		lua = { "stylua" },
		go = { "goimports", "gofumpt" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		json = { "prettier" },
		jsonc = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		html = { "prettier" },
		css = { "prettier" },
		sh = { "shfmt" },
		bash = { "shfmt" },
		sql = { "pg_format" },
	},
})

vim.keymap.set("n", "<leader>cf", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format buffer" })

-- Toggle format-on-save
vim.keymap.set("n", "<leader>tf", function()
	vim.g.disable_autoformat = not vim.g.disable_autoformat
	if vim.g.disable_autoformat then
		vim.notify("Format-on-save disabled", vim.log.levels.INFO)
	else
		vim.notify("Format-on-save enabled", vim.log.levels.INFO)
	end
end, { desc = "Toggle format-on-save" })

-- INFO: gitsigns

require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
})

-- INFO: luasnip

require("luasnip").setup({ enable_autosnippets = true })

-- INFO: mini
require("mini.notify").setup()

local miniclue = require("mini.clue")
miniclue.setup({
	triggers = {
		-- Leader triggers
		{ mode = "n", keys = "<Leader>" },
		{ mode = "x", keys = "<Leader>" },

		-- Built-in completion
		{ mode = "i", keys = "<C-x>" },

		-- `g` key
		{ mode = "n", keys = "g" },
		{ mode = "x", keys = "g" },

		-- Marks
		{ mode = "n", keys = "'" },
		{ mode = "n", keys = "`" },
		{ mode = "x", keys = "'" },
		{ mode = "x", keys = "`" },

		-- Registers
		{ mode = "n", keys = '"' },
		{ mode = "x", keys = '"' },
		{ mode = "i", keys = "<C-r>" },
		{ mode = "c", keys = "<C-r>" },

		-- Window commands
		{ mode = "n", keys = "<C-w>" },

		-- `z` key
		{ mode = "n", keys = "z" },
		{ mode = "x", keys = "z" },
	},

	clues = {
		-- Enhance this by adding descriptions for <Leader> mapping groups
		miniclue.gen_clues.builtin_completion(),
		miniclue.gen_clues.g(),
		miniclue.gen_clues.marks(),
		miniclue.gen_clues.registers(),
		miniclue.gen_clues.windows(),
		miniclue.gen_clues.z(),
	},
})

local pick = require("mini.pick")
local choose_all = function()
	local mappings = pick.get_picker_opts().mappings
	vim.api.nvim_input(mappings.mark_all .. mappings.choose_marked)
end

-- vim.ui.select = require("mini.pick").ui_select
require("mini.pick").setup({
	mappings = {
		choose_all = { char = "<C-q>", func = choose_all },
	},
})

-- Find files (respects .gitignore)
vim.keymap.set("n", "<leader>ff", pick.builtin.files, { desc = "Find files" })

-- Grep/search in files
vim.keymap.set("n", "<leader>/", pick.builtin.grep_live, { desc = "Grep (live)" })

-- Recent files
vim.keymap.set("n", "<leader>fr", function()
	pick.start({ source = { items = vim.v.oldfiles, name = "Oldfiles" } })
end, { desc = "Find recent files" })

-- Buffers
vim.keymap.set("n", "<leader><leader>", pick.builtin.buffers, { desc = "Find buffers" })

-- Help tags
vim.keymap.set("n", "<leader>fh", pick.builtin.help, { desc = "Find help" })

-- Resume last picker
vim.keymap.set("n", "<leader>fl", pick.builtin.resume, { desc = "Resume last picker" })

-- Grep current word under cursor
vim.keymap.set("n", "<leader>fw", function()
	local word = vim.fn.expand("<cword>")
	pick.builtin.grep({ pattern = word })
end, { desc = "Find word under cursor" })

-- Git files (if in a git repo)
vim.keymap.set("n", "<leader>fg", function()
	pick.builtin.files({ tool = "git" })
end, { desc = "Find git files" })

require("mini.statusline").setup({
	set_vim_settings = false,
	use_icons = vim.g.have_nerd_font,
	section_location = function()
		return "%2l:%-2v"
	end,
})

require("mini.ai").setup({ n_lines = 500 })
require("mini.pairs").setup()
require("mini.surround").setup()

-- INFO: catppuccin

require("catppuccin").setup({
	flavour = "mocha", -- latte, frappe, macchiato, mocha
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

-- INFO: vim-go
-- Disable features handled by treesitter/LSP/conform
vim.g.go_gopls_enabled = 0
vim.g.go_code_completion_enabled = 0
vim.g.go_fmt_autosave = 0
vim.g.go_imports_autosave = 0
vim.g.go_mod_fmt_autosave = 0
vim.g.go_doc_keywordprg_enabled = 0
vim.g.go_def_mapping_enabled = 0
vim.g.go_textobj_enabled = 0
vim.g.go_list_type = "quickfix"
