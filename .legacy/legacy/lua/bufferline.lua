require('bufferline').setup {
    options = {
        mode = "buffers",
        numbers = "buffer_id",
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",
        left_mouse_command = "buffer %d",
        middle_mouse_command = nil,
        indicator = { style = '▎' },
        buffer_close_icon = '',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "left" } },
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = true,
        persist_buffer_sort = false,
        separator_style = "slant",
        enforce_regular_tabs = true,
        always_show_bufferline = true,
        sort_by = 'relative_directory'
    }
}
