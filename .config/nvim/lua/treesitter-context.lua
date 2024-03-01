require 'treesitter-context'.setup {
    enable = true,
    max_lines = 0,
    patterns = {
        default = {
            'class',
            'function',
            'method',
            'for',
            'while',
            'if',
            'switch',
            'case',
        },
    },
    exact_patterns = {
    },
    zindex = 20,
}
