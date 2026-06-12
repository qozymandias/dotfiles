return {
    {
        "Isrothy/neominimap.nvim",
        version = "v3.x.x",
        lazy = false,
        keys = {
            { "<leader>nt",  "<cmd>Neominimap Toggle<cr>",      desc = "Toggle global minimap" },
            { "<leader>nf",  "<cmd>Neominimap ToggleFocus<cr>", desc = "Switch focus on minimap" },
            { "<leader>no",  "<cmd>Neominimap Enable<cr>",      desc = "Enable global minimap" },
            { "<leader>nc",  "<cmd>Neominimap Disable<cr>",     desc = "Disable global minimap" },
            { "<leader>nr",  "<cmd>Neominimap Refresh<cr>",     desc = "Refresh global minimap" },
            { "<leader>nwt", "<cmd>Neominimap WinToggle<cr>",   desc = "Toggle minimap for current window" },
            { "<leader>nbt", "<cmd>Neominimap BufToggle<cr>",   desc = "Toggle minimap for current buffer" },
        },
        init = function()

            vim.g.neominimap = {
                auto_enable = true,
                diagnostic = {
                    enabled = true,
                    mode = "icon",
                },
                git = {
                    enabled = true,
                    mode = "icon",
                },
                search = {
                    enabled = true,
                    mode = "icon",
                },
                mark = {
                    enabled = true,
                    mode = "icon",
                },
                treesitter = {
                    enabled = true,
                },
                fold = {
                    enabled = true,
                },
                float = {
                    window_border = "none",
                },
                winopt = function(opt, _)
                    opt.signcolumn = "no"
                    opt.foldcolumn = "0"
                    opt.number = false
                    opt.relativenumber = false
                    opt.statuscolumn = ""
                    opt.winblend = 100
                    opt.winhighlight = table.concat({
                        "Normal:NeominimapBackground",
                        "NormalFloat:NeominimapBackground",
                        "FloatBorder:NeominimapBorder",
                        "CursorLine:NeominimapCursorLine",
                        "CursorLineNr:NeominimapCursorLineNr",
                        "CursorLineSign:NeominimapCursorLineSign",
                        "CursorLineFold:NeominimapCursorLineFold",
                    }, ",")
                end,
                exclude_filetypes = {
                    "help",
                    "snacks_picker_list",
                    "snacks_picker_input",
                    "snacks_dashboard",
                    "snacks_notif",
                    "noice",
                    "lazy",
                    "mason",
                    "TelescopePrompt",
                    "TelescopeResults",
                    "fugitive",
                    "git",
                    "gitcommit",
                    "neo-tree",
                    "Outline",
                    "toggleterm",
                    "dap-repl",
                    "dapui_scopes",
                    "dapui_breakpoints",
                    "dapui_stacks",
                    "dapui_watches",
                    "dapui_console",
                },
                exclude_buftypes = {
                    "nofile",
                    "nowrite",
                    "quickfix",
                    "terminal",
                    "prompt",
                },
            }
        end,
    },
}
