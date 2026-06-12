return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            bigfile     = { enabled = true },
            dashboard   = { enabled = true },
            explorer    = { enabled = true, replace_netrw = false },
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
                                keys = {
                                    ["<Esc>"] = { "focus_main", mode = { "n", "i" } },
                                },
                            },
                            input = {
                                keys = {
                                    ["<Esc>"] = { "focus_main", mode = { "n", "i" } },
                                },
                            },
                        },
                        actions = {
                            focus_main = function(picker)
                                for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
                                    local buf = vim.api.nvim_win_get_buf(win)
                                    local ft = vim.bo[buf].filetype
                                    if not ft:match("^snacks_") and vim.api.nvim_win_get_config(win).relative == "" then
                                        vim.api.nvim_set_current_win(win)
                                        return
                                    end
                                end
                            end,
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
                    local cur_ft = vim.bo.filetype
                    -- Going BACK from explorer: jump to the window we came from
                    -- if it's still valid, otherwise fall back to the first
                    -- non-snacks regular window.
                    if cur_ft:match("^snacks_picker") then
                        local prev = vim.t.snacks_explorer_prev_win
                        if prev and vim.api.nvim_win_is_valid(prev) then
                            local buf = vim.api.nvim_win_get_buf(prev)
                            local ft = vim.bo[buf].filetype
                            if not ft:match("^snacks_")
                                and vim.api.nvim_win_get_config(prev).relative == ""
                            then
                                vim.api.nvim_set_current_win(prev)
                                return
                            end
                        end
                        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
                            local buf = vim.api.nvim_win_get_buf(win)
                            local ft = vim.bo[buf].filetype
                            if not ft:match("^snacks_") and vim.api.nvim_win_get_config(win).relative == "" then
                                vim.api.nvim_set_current_win(win)
                                return
                            end
                        end
                        return
                    end
                    -- Going TO explorer: remember which window we were in so
                    -- the next <leader>e returns here, not to the topmost
                    -- window in creation order.
                    vim.t.snacks_explorer_prev_win = vim.api.nvim_get_current_win()
                    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
                        local buf = vim.api.nvim_win_get_buf(win)
                        if vim.bo[buf].filetype:match("^snacks_picker_list") then
                            vim.api.nvim_set_current_win(win)
                            return
                        end
                    end
                    Snacks.explorer()
                end,
                desc = "Toggle focus file explorer",
            },
        },
        init = function()
            vim.api.nvim_create_autocmd("VimEnter", {
                callback = function()
                    if vim.fn.argc() == 0 then return end
                    local origin = vim.api.nvim_get_current_tabpage()
                    local tabs = vim.api.nvim_list_tabpages()
                    local function open_for(idx)
                        local tab = tabs[idx]
                        if not tab then
                            if vim.api.nvim_tabpage_is_valid(origin) then
                                vim.api.nvim_set_current_tabpage(origin)
                            end
                            return
                        end
                        vim.api.nvim_set_current_tabpage(tab)
                        Snacks.explorer({ focus = false })
                        vim.defer_fn(function() open_for(idx + 1) end, 50)
                    end
                    vim.schedule(function() open_for(1) end)
                end,
            })

            vim.api.nvim_create_autocmd("TabNew", {
                callback = function()
                    -- Capture the tab now: when several tabs are created in
                    -- one batch (e.g. telescope multi-select + <C-t>), every
                    -- TabNew schedules a callback that only runs once the loop
                    -- has finished, by which point the current tab is the last
                    -- one. Without capturing, all explorers open on that final
                    -- tab. Switch to the captured tab and skip if it already
                    -- has an explorer.
                    local tab = vim.api.nvim_get_current_tabpage()
                    vim.schedule(function()
                        if not vim.api.nvim_tabpage_is_valid(tab) then return end
                        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
                            local buf = vim.api.nvim_win_get_buf(win)
                            if vim.bo[buf].filetype:match("^snacks_picker_list") then
                                return
                            end
                        end
                        vim.api.nvim_set_current_tabpage(tab)
                        Snacks.explorer({ focus = false })
                    end)
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
