return {
    {
        "stevearc/oil.nvim",
        cmd = "Oil",
        keys = {
            {
                "<leader>oe",
                function()
                    local file_dir = vim.fn.expand("%:p:h")
                    require("oil").open_float(file_dir)
                end,
                desc = "Open Oil (floating, top-right)",
            },
        },
        opts = {
            default_file_explorer = false,
            view_options = { show_hidden = true },
            float = {
                padding = 2,
                max_width = 0.25,
                max_height = 0.4,
                border = "rounded",
                win_options = { winblend = 10 },
                override = function(conf)
                    local width = math.floor(vim.o.columns * 0.25)
                    local height = math.floor(vim.o.lines * 0.4)
                    conf.anchor = "NE"
                    conf.row = 1
                    conf.col = vim.o.columns
                    conf.width = width
                    conf.height = height
                    return conf
                end,
            },
            keymaps = {
                ["<Esc>"] = "actions.close",
            },
        },
    },
}
