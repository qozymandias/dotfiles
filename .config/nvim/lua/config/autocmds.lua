-- Autocommands: filetype tweaks, restore cursor, TODO highlighting, custom highlights.

local au = vim.api.nvim_create_autocmd
local grp = vim.api.nvim_create_augroup

au("BufReadPost", {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

au("FileType", {
    pattern = { "javascript", "typescript", "typescriptreact" },
    callback = function()
        vim.bo.tabstop = 2
        vim.bo.shiftwidth = 2
        vim.bo.expandtab = true
    end,
})

vim.filetype.add({
    extension = {
        ac = "c",
        cl = "cuda",
        hsc = "haskell",
        pbt = "haskell",
        kt = "kotlin",
    },
    filename = {
        xmobarrc = "haskell",
    },
})

local todo_grp = grp("vimrc_todo", { clear = true })
au("Syntax", {
    group = todo_grp,
    pattern = "*",
    command = [[syn match MyTodo /\v<(FIXME|TODO|OPTIMIZE|XXX|todo)/ containedin=.*Comment,vimCommentTitle]],
})
vim.cmd("hi def link MyTodo Todo")
