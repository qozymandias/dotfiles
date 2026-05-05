return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            bigfile     = { enabled = true },
            dashboard   = { enabled = true },
            indent      = { enabled = true },
            input       = { enabled = true },
            notifier    = { enabled = true, timeout = 3000 },
            quickfile   = { enabled = true },
            scope       = { enabled = true },
            scroll      = { enabled = true },
            statuscolumn = { enabled = true },
            words       = { enabled = true },
        },
        keys = {
            { "<leader>nn", function() Snacks.notifier.show_history() end, desc = "Notification history" },
            { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss notifications" },
        },
    },
}
