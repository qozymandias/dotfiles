require("nvim-lsp-installer").setup({
    ensure_installed = {
        "yamlls", "ts_ls", "pyright", "html", "vimls", "jsonls", "rust_analyzer", "lua_ls", "texlab", "cssls"
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
