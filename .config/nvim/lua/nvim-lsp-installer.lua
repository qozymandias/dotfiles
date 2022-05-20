require("nvim-lsp-installer").setup({
    ensure_installed = {
        "pyright", "sumneko_lua", "vimls", "jsonls", "bashls", "yamlls", "html", "tsserver", "eslint", "emmet_ls"
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
