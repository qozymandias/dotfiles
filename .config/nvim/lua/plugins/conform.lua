return {
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                "<leader>fo",
                function()
                    require("conform").format({ async = true, lsp_fallback = true })
                end,
                desc = "Format buffer",
            },
        },
        opts = {
            formatters_by_ft = {
                python = { "black" },
                javascript = { "prettier" },
                javascriptreact = { "prettier" },
                typescript = { "prettier" },
                typescriptreact = { "prettier" },
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                html = { "prettier" },
                css = { "prettier" },
                scss = { "prettier" },
                sh = { "shfmt" },
                bash = { "shfmt" },
                zsh = { "shfmt" },
                rust = { "rustfmt" },
                lua = { "stylua" },
            },
            formatters = {
                prettier = {
                    prepend_args = { "--trailing-comma", "es5" },
                },
                shfmt = {
                    prepend_args = { "-i", "4" },
                },
            },
        },
    },
}
