return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local langs = {
                "bash", "c", "cpp", "css", "diff", "dockerfile", "git_config",
                "git_rebase", "gitcommit", "gitignore", "go", "haskell", "html",
                "javascript", "json", "kotlin", "lua", "luadoc",
                "luap", "make", "markdown", "markdown_inline", "python", "query",
                "regex", "rust", "scss", "sql", "toml", "tsx", "typescript",
                "vim", "vimdoc", "yaml", "zig",
            }

            require("nvim-treesitter").setup()

            local installed = require("nvim-treesitter.config").get_installed("parsers")
            local installed_set = {}
            for _, p in ipairs(installed) do installed_set[p] = true end

            local missing = {}
            for _, lang in ipairs(langs) do
                if not installed_set[lang] then table.insert(missing, lang) end
            end
            if #missing > 0 then
                require("nvim-treesitter").install(missing)
            end

            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    local ft = vim.bo[args.buf].filetype
                    local lang = vim.treesitter.language.get_lang(ft) or ft
                    if not pcall(vim.treesitter.start, args.buf, lang) then
                        return
                    end
                    if vim.treesitter.query.get(lang, "indents") then
                        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                end,
            })
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            enable = true,
            max_lines = 5,
            min_window_height = 0,
            line_numbers = true,
            multiline_threshold = 20,
            trim_scope = "outer",
            mode = "cursor",
            separator = nil,
            zindex = 20,
            on_attach = nil,
        },
    },
}
