local previewers = require("telescope.previewers")

local _bad = { "node_modules", ".*%.txt", ".*%.csv", ".*%.lua", "*conan*" } -- Put all filetypes that slow you down in this array
local bad_files = function(filepath)
    for _, v in ipairs(_bad) do
        if filepath:match(v) then
            return false
        end
    end

    return true
end

local new_maker = function(filepath, bufnr, opts)
    opts = opts or {}
    if opts.use_ft_detect == nil then opts.use_ft_detect = true end
    opts.use_ft_detect = opts.use_ft_detect == false and false or bad_files(filepath)
    previewers.buffer_previewer_maker(filepath, bufnr, opts)
end

require 'telescope'.setup {
    defaults = {
        prompt_prefix = '=> ',
        selection_caret = '-> ',
        mappings = {
        },
        vimgrep_arguments = {
            "rg",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            -- "--trim" -- add this value
        },
        buffer_previewer_maker = new_maker,
        entry_prefix = " ",
        initial_mode = "insert",
        selection_strategy = "closest",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
                results_width = 0.8,
            },
            vertical = {
                mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = _bad,
        generic_sorter = require("telescope.sorters").get_fuzzy_with_index_bias,
        path_display = { "smart" },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        use_less = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        cache_picker = {
            num_pickers = 128,
            limit_entries = 1000
        },
        extensions = {
            fzy_native = {
                override_generic_sorter = false,
                override_file_sorter = true,
            }
        }
    },
}
