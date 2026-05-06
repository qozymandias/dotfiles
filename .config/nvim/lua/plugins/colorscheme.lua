return {
    {
        "qozymandias/NeoSolarized.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("NeoSolarized").setup({
                style = "light",
                transparent = false,
                terminal_colors = true,
                enable_italics = true,
                styles = {
                    comments = { italic = true },
                    keywords = { italic = false },
                    functions = {},
                    variables = {},
                    string = {},
                    underline = true,
                    undercurl = true,
                },
            })
            vim.o.background = "light"
            vim.cmd.colorscheme("NeoSolarized")
        end,
    },
}
