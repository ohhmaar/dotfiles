vim.pack.add({
	{ src = "https://github.com/saghen/blink.cmp", version = "v1.8.0" },
})

require("blink.cmp").setup({
	keymap = { preset = "default" },
	appearance = {
		nerd_font_variant = "mono",
	},
	completion = { documentation = { auto_show = true } },
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	fuzzy = {
		implementation = "prefer_rust",
		prebuilt_binaries = {
			force_version = "v1.8.0",
		},
	},
})
