return {
	settings = {
		Lua = {
			-- workspace = {
			-- library = vim.api.nvim_get_runtime_file("", true),
			-- },
			diagnostics = {
				disable = { "missing-parameters", "missing-fields" },
				globals = { "vim" },
			},
		},
	},

	-- single_file_support = true,
	-- log_level = vim.lsp.protocol.MessageType.Warning,
}
