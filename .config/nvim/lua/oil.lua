require("oil").setup({
    default_file_explorer = false,
    view_options = {
        show_hidden = true,
    },
    float = {
        padding = 2,
        max_width = 0.25,
        max_height = 0.4,
        border = "rounded",
        win_options = {
            winblend = 10,
        },
        override = function(conf)
            local width = math.floor(vim.o.columns * 0.25)
            local height = math.floor(vim.o.lines * 0.4)
            conf.anchor = "NE"
            conf.row = 1
            conf.col = vim.o.columns
            conf.width = width
            conf.height = height
            return conf
        end,
    },
    keymaps = {
        ["<Esc>"] = "actions.close",
    },
})

vim.keymap.set("n", "<leader>e", function()
    local file_dir = vim.fn.expand("%:p:h")
    require("oil").open_float(file_dir)
end, { desc = "Open Oil in floating window (top-right)" })

-- -- helper to open oil in float on current buffer dir
-- local function open_oil_float_unfocused()
--   local oil = require("oil")
--   local dir = vim.fn.expand("%:p:h")
--   oil.open_float(dir)
--   vim.cmd("wincmd p") -- return focus to previous window
-- end
--
-- -- open automatically when creating or switching tabs
-- vim.api.nvim_create_autocmd({"TabNew", "TabEnter"}, {
--   callback = open_oil_float_unfocused,
-- })
