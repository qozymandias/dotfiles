return {
    {
        "maxmx03/solarized.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            transparent = { enabled = false },
            styles = {
                comments = { italic = true },
            },
        },
        config = function(_, opts)
            require("solarized").setup(opts)
            vim.cmd.colorscheme("solarized")
        end,
    },
}
