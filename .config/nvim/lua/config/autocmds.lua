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

au({ "BufNewFile", "BufRead" }, { pattern = "*.ac", command = "setlocal filetype=c" })
au({ "BufNewFile", "BufRead" }, { pattern = "*.cl", command = "setlocal filetype=cuda" })
au({ "BufNewFile", "BufRead" }, { pattern = "*.hsc", command = "setlocal filetype=haskell" })
au({ "BufNewFile", "BufRead" }, { pattern = "*.pbt", command = "setlocal filetype=haskell" })
au({ "BufNewFile", "BufRead" }, { pattern = "xmobarrc", command = "setlocal filetype=haskell" })
au({ "BufNewFile", "BufRead" }, { pattern = "*.kt", command = "setlocal filetype=kotlin" })
au({ "BufNewFile", "BufRead" }, { pattern = { "*.tex", "*.sty", "*.cls" }, command = "setlocal filetype=tex" })

local todo_grp = grp("vimrc_todo", { clear = true })
au("Syntax", {
    group = todo_grp,
    pattern = "*",
    command = [[syn match MyTodo /\v<(FIXME|TODO|OPTIMIZE|XXX|todo)/ containedin=.*Comment,vimCommentTitle]],
})
vim.cmd("hi def link MyTodo Todo")

au("ColorScheme", {
    pattern = "*",
    callback = function()
        vim.api.nvim_set_hl(0, "Function", { fg = "white", bg = "#1f2335" })
        vim.api.nvim_set_hl(0, "BufferLineTabSelected", { bg = "#fdf6e3", fg = "#586e75", bold = true })
        vim.api.nvim_set_hl(0, "BufferLineIndicatorSelected", { bg = "#fdf6e3", fg = "#268bd2", bold = true })
        vim.api.nvim_set_hl(0, "Pmenu", { bg = "LightYellow", fg = "Magenta" })
        vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "white" })
    end,
})
