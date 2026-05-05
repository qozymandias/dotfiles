require 'nvim-treesitter.configs'.setup {
    ensure_installed = "",
    sync_install = true,
    ignore_install = { "" },
    autopairs = {
        enable = true,
    },
    indent = { enable = false, disable = { "yaml" } },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    }
}
