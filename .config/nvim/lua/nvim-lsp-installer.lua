require("nvim-lsp-installer").setup({
    ensure_installed = {
        "pyright", "vimls", "jsonls", "bashls", "yamlls", "html", "tsserver" 
    },
    automatic_installation = false,
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})
