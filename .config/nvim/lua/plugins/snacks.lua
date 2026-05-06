return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            bigfile     = { enabled = true },
            dashboard   = { enabled = true },
            explorer    = { enabled = true, replace_netrw = true },
            indent      = { enabled = false },
            input       = { enabled = true },
            notifier    = { enabled = true, timeout = 3000 },
            picker      = {
                enabled = true,
                sources = {
                    explorer = {
                        layout = {
                            preset = "sidebar",
                            preview = false,
                            layout = { position = "left", width = 32 },
                        },
                        auto_close = false,
                        jump = { close = false },
                        hidden = true,
                        win = {
                            list = {
                                wo = {
                                    number = false,
                                    relativenumber = false,
                                    winfixwidth = true,
                                },
                            },
                        },
                    },
                },
            },
            quickfile   = { enabled = true },
            scope       = { enabled = false },
            scroll      = { enabled = false },
            statuscolumn = { enabled = true },
            words       = { enabled = true },
        },
        keys = {
            { "<leader>nn", function() Snacks.notifier.show_history() end, desc = "Notification history" },
            { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss notifications" },
            { "<leader>fe", function() Snacks.explorer({ focus = false }) end, desc = "File explorer" },
            { "<leader>fE", function() Snacks.explorer.reveal({ focus = false }) end, desc = "Reveal current file in explorer" },
            {
                "<leader>e",
                function()
                    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
                        local buf = vim.api.nvim_win_get_buf(win)
                        if vim.bo[buf].filetype:match("^snacks_picker_list") then
                            vim.api.nvim_set_current_win(win)
                            return
                        end
                    end
                    Snacks.explorer()
                end,
                desc = "Focus file explorer",
            },
        },
        init = function()
            vim.api.nvim_create_autocmd("VimEnter", {
                callback = function()
                    if vim.fn.argc() == 0 then return end
                    vim.schedule(function() Snacks.explorer({ focus = false }) end)
                end,
            })

            vim.api.nvim_create_autocmd("TabNew", {
                callback = function()
                    vim.schedule(function() Snacks.explorer({ focus = false }) end)
                end,
            })

            vim.api.nvim_create_autocmd("QuitPre", {
                callback = function()
                    local non_explorer = 0
                    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
                        local buf = vim.api.nvim_win_get_buf(win)
                        local ft = vim.bo[buf].filetype
                        if not ft:match("^snacks_") and vim.api.nvim_win_get_config(win).relative == "" then
                            non_explorer = non_explorer + 1
                        end
                    end
                    if non_explorer <= 1 then
                        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
                            local buf = vim.api.nvim_win_get_buf(win)
                            if vim.bo[buf].filetype:match("^snacks_") then
                                pcall(vim.api.nvim_win_close, win, true)
                            end
                        end
                    end
                end,
            })
        end,
    },
}
