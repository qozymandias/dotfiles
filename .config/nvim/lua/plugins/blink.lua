return {
    {
        "saghen/blink.cmp",
        version = "*",
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = { "rafamadriz/friendly-snippets" },
        opts = {
            keymap = {
                preset = "default",
                -- Tab cycles through entries; each press highlights the next
                -- item and inserts its text as a preview (auto_insert below).
                -- Menu stays open until <CR> commits or <C-e> cancels.
                ["<Tab>"] = { "show", "select_next", "fallback" },
                ["<S-Tab>"] = { "show", "select_prev", "fallback" },
                ["<CR>"] = { "accept", "fallback" },
                ["<C-m>"] = { "accept", "fallback" },
                ["<C-e>"] = { "cancel", "fallback" },
                ["<C-b>"] = { "scroll_documentation_up", "fallback" },
                ["<C-f>"] = { "scroll_documentation_down", "fallback" },
            },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = "mono",
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
            completion = {
                documentation = { auto_show = true },
                menu = { border = "rounded" },
                -- Make Tab "preview-cycle": the highlighted entry's text is
                -- inserted into the buffer while the menu stays open. <CR>
                -- commits whatever is currently inserted; <C-e> cancels and
                -- restores the original text. preselect=false so the menu
                -- doesn't auto-pick before the first Tab.
                list = {
                    selection = { preselect = false, auto_insert = true },
                },
            },
            cmdline = {
                enabled = true,
                keymap = {
                    preset = "cmdline",
                    -- Same preview-cycle UX in the cmdline.
                    ["<Tab>"] = { "show", "select_next", "fallback" },
                    ["<S-Tab>"] = { "show", "select_prev", "fallback" },
                },
                completion = {
                    menu = { auto_show = true },
                    list = {
                        selection = { preselect = false, auto_insert = true },
                    },
                },
            },
        },
        opts_extend = { "sources.default" },
    },
}
