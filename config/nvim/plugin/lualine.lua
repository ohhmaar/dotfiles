vim.pack.add({
	{ src = "https://github.com/nvim-lualine/lualine.nvim", name = "lualine" },
})

local lualine = require("lualine")
local palette = require("catppuccin.palettes").get_palette()

local colors = {
	bg = palette.mantle,
	fg = palette.text,
	yellow = palette.yellow,
	cyan = palette.sapphire,
	green = palette.green,
	orange = palette.peach,
	violet = palette.mauve,
	magenta = palette.pink,
	blue = palette.blue,
	red = palette.red,
}

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
}

local mode_colors = {
	n = colors.red,
	i = colors.green,
	v = colors.blue,
	[""] = colors.blue,
	V = colors.blue,
	c = colors.magenta,
	no = colors.red,
	s = colors.orange,
	S = colors.orange,
	[""] = colors.orange,
	ic = colors.yellow,
	R = colors.violet,
	Rv = colors.violet,
	cv = colors.red,
	ce = colors.red,
	r = colors.cyan,
	rm = colors.cyan,
	["r?"] = colors.cyan,
	["!"] = colors.red,
	t = colors.red,
}

local config = {
	options = {
		component_separators = "",
		section_separators = "",
		globalstatus = true,
		theme = {
			normal = { c = { fg = colors.fg, bg = colors.bg } },
			inactive = { c = { fg = colors.fg, bg = colors.bg } },
		},
	},
	sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
}

local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
end

local function ins_right(component)
	table.insert(config.sections.lualine_x, component)
end

ins_left({
	function()
		return "▊"
	end,
	color = { fg = colors.blue },
	padding = { left = 0, right = 1 },
})

ins_left({
	"mode",
	fmt = function(str)
		return str:upper()
	end,
	color = function()
		return { fg = mode_colors[vim.fn.mode()], gui = "bold" }
	end,
	padding = { right = 1 },
})

ins_left({
	"location",
	color = { fg = colors.fg, gui = "bold" },
})

ins_left({
	"filename",
	cond = conditions.buffer_not_empty,
	color = { fg = colors.magenta, gui = "bold" },
})

ins_right({
	"diagnostics",
	sources = { "nvim_diagnostic" },
	symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
	diagnostics_color = {
		error = { fg = colors.red },
		warn = { fg = colors.yellow },
		info = { fg = colors.cyan },
		hint = { fg = colors.green },
	},
	colored = true,
	update_in_insert = false,
})

ins_right({
	"filetype",
	colored = true,
	icon_only = false,
	padding = { left = 0, right = 0 },
})

ins_right({
	function()
		local current = vim.fn.line(".")
		local total = math.max(vim.fn.line("$"), 1)
		return string.format("%d%%%%", math.floor((current / total) * 100))
	end,
	color = { fg = colors.fg, gui = "bold" },
})

ins_right({
	"diff",
	symbols = { added = " ", modified = "󰝤 ", removed = " " },
	diff_color = {
		added = { fg = colors.green },
		modified = { fg = colors.orange },
		removed = { fg = colors.red },
	},
	cond = conditions.hide_in_width,
})

ins_right({
	"branch",
	icon = "",
	color = { fg = colors.violet, gui = "bold" },
})

ins_right({
	function()
		return "▊"
	end,
	color = { fg = colors.blue },
	padding = { left = 1 },
})

lualine.setup(config)
