vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("my.lsp", {}),
	callback = function(args)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf, desc = "Go to definition" })
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = args.buf, desc = "Go to implementation" })
		vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = args.buf, desc = "References" })
		vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = args.buf, desc = "Type definition" })
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = args.buf, desc = "Rename symbol" })
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
	end,
})
