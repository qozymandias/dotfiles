return {
    {
        "rayliwell/tree-sitter-rstml",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        ft = "rust",
        build = ":TSUpdate",
        config = function()
            require("tree-sitter-rstml").setup()
        end,
    },

    {
        "windwp/nvim-ts-autotag",
        ft = { "rust", "html", "xml", "tsx", "jsx", "vue", "svelte", "markdown" },
        opts = {},
    },

    {
        "Saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        opts = {
            completion = {
                crates = { enabled = true },
                cmp = { enabled = false },
                blink = { enabled = true },
            },
            lsp = {
                enabled = true,
                actions = true,
                completion = true,
                hover = true,
            },
        },
    },
}
