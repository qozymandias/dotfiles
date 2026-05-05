return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local colors = { black = "#282828" }
            local custom_gruvbox = require("lualine.themes.gruvbox_light")
            for _, mode in ipairs({ "normal", "insert", "visual" }) do
                custom_gruvbox[mode].c.fg = colors.black
                custom_gruvbox[mode].c.gui = "bold"
            end

            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = custom_gruvbox,
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
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
                extensions = { "fugitive", "neo-tree", "nvim-dap-ui", "overseer" },
            })
        end,
    },
}
