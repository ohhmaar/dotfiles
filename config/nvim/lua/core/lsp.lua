-- Define capabilities for LSP clients
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Configure capabilities for all servers
vim.lsp.config('*', {
    capabilities = capabilities
})

-- Enable LSP servers
vim.lsp.enable({
    "gopls",
    "lua_ls",
    "ts_ls",
    "terraformls"
})

vim.diagnostic.config({
    virtual_text = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = true,
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.WARN] = "WarningMsg",
        },
    },
})
