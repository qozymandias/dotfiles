return {
    {
        "chentoast/marks.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            default_mappings = true,
            builtin_marks = { ".", "<", ">", "^" },
            cyclic = true,
            force_write_shada = false,
            refresh_interval = 250,
            sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
            excluded_filetypes = { "neo-tree", "dashboard", "snacks_dashboard" },
            bookmark_0 = { sign = "*", virt_text = "bookmark" },
            mappings = {},
        },
        keys = {
            { "<leader>bc", "<cmd>MarksListBuf<cr>", desc = "Buffer marks" },
            { "<leader>ba", "<cmd>MarksListAll<cr>", desc = "All marks" },
        },
    },
}
