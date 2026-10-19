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
            lazygit     = { enabled = true },
            notifier    = { enabled = true, timeout = 3000 },
            picker      = {
                enabled = true,
                sources = {
                    explorer = {
                        layout = { layout = { width = 32 } },
                        hidden = true,
                        win = {
                            list = {
                                wo = { winfixwidth = true },
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
                            focus_main = function(picker) vim.api.nvim_set_current_win(picker.main) end,
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
            { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
            { "<leader>nn", function() Snacks.notifier.show_history() end, desc = "Notification history" },
            { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss notifications" },
            { "<leader>fe", function() Snacks.explorer({ focus = false }) end, desc = "File explorer" },
            { "<leader>fE", function() Snacks.explorer.reveal({ focus = false }) end, desc = "Reveal current file in explorer" },
            {
                "<leader>e",
                function()
                    local explorer = Snacks.picker.get({ source = "explorer" })[1]
                    if not explorer then return Snacks.explorer() end
                    if explorer:is_focused() then
                        vim.api.nvim_set_current_win(explorer.main)
                    else
                        explorer:focus("list")
                    end
                end,
                desc = "Toggle focus file explorer",
            },
        },
        init = function()
            vim.env.LG_CONFIG_FILE = vim.fn.stdpath("config") .. "/lazygit.yml"

            -- Serialize explorer creation. Snacks opens the explorer window
            -- asynchronously, so creating several tabs in one batch (telescope
            -- multi-select + <C-t>, or `nvim -p`) races and stacks multiple
            -- explorers on one tab. Draining a queue with a 50ms stagger opens
            -- exactly one explorer per tab.
            local explorer_queue = {}
            local explorer_draining = false
            local explorer_return_tab

            local function tab_has_explorer(tab)
                for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
                    local buf = vim.api.nvim_win_get_buf(win)
                    if vim.bo[buf].filetype:match("^snacks_picker_list") then
                        return true
                    end
                end
                return false
            end

            local function drain_explorer_queue()
                if explorer_draining then return end
                explorer_draining = true
                local function step()
                    local tab = table.remove(explorer_queue, 1)
                    if not tab then
                        explorer_draining = false
                        if vim.api.nvim_tabpage_is_valid(explorer_return_tab) then
                            vim.api.nvim_set_current_tabpage(explorer_return_tab)
                        end
                        return
                    end
                    if vim.api.nvim_tabpage_is_valid(tab) and not tab_has_explorer(tab) then
                        vim.api.nvim_set_current_tabpage(tab)
                        Snacks.explorer({ focus = false })
                    end
                    vim.defer_fn(step, 50)
                end
                step()
            end

            -- return_tab is where the user ends up once the queue drains: the origin tab at startup, the newest
            -- tab after TabNew.
            local function enqueue_explorer(tab, return_tab)
                explorer_return_tab = return_tab
                if not vim.api.nvim_tabpage_is_valid(tab) or tab_has_explorer(tab) then return end
                if vim.tbl_contains(explorer_queue, tab) then return end
                explorer_queue[#explorer_queue + 1] = tab
                drain_explorer_queue()
            end

            vim.api.nvim_create_autocmd("VimEnter", {
                callback = function()
                    if vim.fn.argc() == 0 then return end
                    vim.schedule(function()
                        local origin = vim.api.nvim_get_current_tabpage()
                        for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
                            enqueue_explorer(tab, origin)
                        end
                    end)
                end,
            })

            vim.api.nvim_create_autocmd("TabNew", {
                callback = function()
                    -- Capture the tab now: several TabNew events fired in one
                    -- batch (telescope multi-select + <C-t>) all resolve after
                    -- the loop, when the current tab is the last one.
                    local tab = vim.api.nvim_get_current_tabpage()
                    vim.schedule(function() enqueue_explorer(tab, tab) end)
                end,
            })

            vim.api.nvim_create_autocmd("QuitPre", {
                callback = function()
                    local wins = vim.api.nvim_tabpage_list_wins(0)
                    local function is_snacks(win)
                        return vim.bo[vim.api.nvim_win_get_buf(win)].filetype:match("^snacks_") ~= nil
                    end
                    local regular = vim.tbl_filter(function(win)
                        return not is_snacks(win) and vim.api.nvim_win_get_config(win).relative == ""
                    end, wins)
                    if #regular > 1 then return end
                    for _, win in ipairs(wins) do
                        if is_snacks(win) then pcall(vim.api.nvim_win_close, win, true) end
                    end
                end,
            })
        end,
    },
}
