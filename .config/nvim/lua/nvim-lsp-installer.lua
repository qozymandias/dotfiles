require("nvim-lsp-installer").setup({
    ensure_installed = {
        "bashls", "yamlls", "ts_ls", "pyright", "html", "vimls", "jsonls", "rust_analyzer", "lua_ls", "texlab"
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
