return {
    {
        "stevearc/overseer.nvim",
        cmd = { "OverseerRun", "OverseerToggle", "OverseerOpen", "OverseerLoadBundle" },
        keys = {
            { "<leader>b",  "<cmd>OverseerRun<cr>",    desc = "Run task" },
            { "<leader>bt", "<cmd>OverseerToggle<cr>", desc = "Toggle task list" },
        },
        opts = {
            templates = { "builtin", "user.cargo_build", "user.cargo_test" },
            task_list = {
                direction = "bottom",
                min_height = 12,
                max_height = 20,
            },
        },
    },
}
