require("neo-tree").setup({
    close_if_last_window = false,
    enable_git_status = false,
    enable_diagnostics = false,

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
        mappings = {
            ["<CR>"] = "noop",
        },
    },
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "neo-tree",
    callback = function()
        vim.wo.number = false
        vim.wo.relativenumber = false
        vim.wo.winfixwidth = true
    end
})

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.cmd("Neotree position=left action=show")
        vim.cmd("wincmd p")
    end
})

vim.api.nvim_create_autocmd("TabNewEntered", {
    callback = function()
        vim.cmd("Neotree position=left action=show")
        vim.cmd("wincmd p")
    end,
})
