require 'toggleterm'.setup {
    shell = vim.o.shell,
    autochdir = true,
    start_in_insert = true,
    close_on_exit = true,
    insert_mappings = true,
    terminal_mappings = true,
    direction =  'float' ,
    size = function(term)
        if term.direction == "horizontal" then
            return 15
        elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
        end
    end,
    persist_size = false,
    float_opts = {
        border = 'curved',
        width = 120,
        height = 15,
        winblend = 3,
    },
}
