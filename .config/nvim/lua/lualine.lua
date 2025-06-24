local colors = {
    black        = '#282828',
    white        = '#ebdbb2',
    red          = '#fb4934',
    green        = '#b8bb26',
    blue         = '#83a598',
    yellow       = '#fe8019',
    gray         = '#a89984',
    darkgray     = '#3c3836',
    lightgray    = '#504945',
    inactivegray = '#7c6f64',
}

local custom_gruvbox = require 'lualine.themes.gruvbox_light'

custom_gruvbox.normal.c.fg = colors.black
custom_gruvbox.normal.c.gui = "bold"
custom_gruvbox.insert.c.fg = colors.black
custom_gruvbox.insert.c.gui = "bold"
custom_gruvbox.visual.c.fg = colors.black
custom_gruvbox.visual.c.gui = "bold"

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = custom_gruvbox,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = true,
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'diff', 'diagnostics' },
        -- lualine_c = {'filename'},
        --'branch',
        lualine_c = { { 'filename', path = 1 }, 'data', "require'lsp-status'.status()", },

        lualine_x = { "os.date('%a')", 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {}
}
