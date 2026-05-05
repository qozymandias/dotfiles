return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        cmd = "Neotree",
        config = function()
            require("neo-tree").setup({
                close_if_last_window = false,
                enable_git_status = true,
                enable_diagnostics = true,
                filesystem = {
                    follow_current_file = {
                        enabled = true,
                        leave_dirs_open = false,
                    },
                    hijack_netrw_behavior = "disabled",
                },
                window = {
                    position = "left",
                    width = 32,
                    mappings = { ["<CR>"] = "noop" },
                },
            })

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "neo-tree",
                callback = function()
                    vim.wo.number = false
                    vim.wo.relativenumber = false
                    vim.wo.winfixwidth = true
                end,
            })

            vim.api.nvim_create_autocmd("VimEnter", {
                callback = function()
                    if vim.fn.argc() == 0 then
                        return
                    end
                    vim.cmd("Neotree position=left action=show")
                    vim.cmd("wincmd p")
                end,
            })

            vim.api.nvim_create_autocmd("TabNewEntered", {
                callback = function()
                    vim.cmd("Neotree position=left action=show")
                    vim.cmd("wincmd p")
                end,
            })
        end,
    },
}
