return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = "NeoSolarized",
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                    disabled_filetypes = {},
                    always_divide_middle = true,
                    globalstatus = true,
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "diff", "diagnostics" },
                    lualine_c = { { "filename", path = 1 } },
                    lualine_x = { "os.date('%a')", "encoding", "fileformat", "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = { "location" },
                    lualine_y = {},
                    lualine_z = {},
                },
                tabline = {},
                extensions = { "fugitive", "nvim-dap-ui", "overseer" },
            })
        end,
    },
}
