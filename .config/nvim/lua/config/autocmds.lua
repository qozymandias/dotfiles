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

local nm_grp = grp("neominimap_transparent", { clear = true })
au({ "ColorScheme", "VimEnter" }, {
    group = nm_grp,
    callback = function()
        for _, hl in ipairs({
            "NeominimapBackground",
            "NeominimapBorder",
            "NeominimapCursorLine",
        }) do
            vim.api.nvim_set_hl(0, hl, { bg = "NONE", ctermbg = "NONE" })
        end
    end,
})

-- Open directories with snacks.explorer in the CURRENT window instead of
-- letting snacks (or netrw) take over the sidebar. Without this, doing
-- `:e some/dir/` swaps the sidebar's contents for that directory and the
-- previous sidebar state is lost. We delete the empty directory buffer that
-- nvim auto-creates and launch a one-shot explorer rooted at that path.
local dir_grp = grp("open_directory_in_window", { clear = true })
au({ "BufEnter", "VimEnter" }, {
    group = dir_grp,
    callback = function(args)
        local path = vim.api.nvim_buf_get_name(args.buf)
        if path == "" then return end
        if vim.fn.isdirectory(path) ~= 1 then return end
        if vim.bo[args.buf].filetype:match("^snacks_") then return end
        vim.schedule(function()
            if vim.api.nvim_buf_is_valid(args.buf) then
                pcall(vim.api.nvim_buf_delete, args.buf, { force = true })
            end
            local ok, snacks = pcall(require, "snacks")
            if not ok then return end
            snacks.picker.explorer({
                cwd = path,
                auto_close = true,
                jump = { close = true },
                layout = { preset = "default", preview = true },
            })
        end)
    end,
})
