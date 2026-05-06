return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
            "saghen/blink.cmp",
        },
        config = function()
            local opts = { noremap = true, silent = true }
            vim.keymap.set("n", "<leader>i", vim.diagnostic.open_float, opts)
            vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, opts)
            vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, opts)
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
            vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

            vim.diagnostic.config({
                virtual_text = { prefix = "●" },
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "",
                        [vim.diagnostic.severity.WARN]  = "",
                        [vim.diagnostic.severity.INFO]  = "",
                        [vim.diagnostic.severity.HINT]  = "",
                    },
                },
                underline = true,
                update_in_insert = false,
                severity_sort = true,
                jump = {
                    on_jump = function() vim.diagnostic.open_float() end,
                },
            })

            local capabilities = require("blink.cmp").get_lsp_capabilities()
            local flag_args = { debounce_text_changes = 150 }

            local lsp_list = {
                "cssls", "marksman", "ts_ls", "yamlls", "taplo",
                "bashls", "pyright", "html", "vimls", "jsonls",
                "lua_ls", "texlab",
            }

            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = lsp_list,
                automatic_enable = lsp_list,
            })

            vim.lsp.config("*", {
                capabilities = capabilities,
                flags = flag_args,
            })

            vim.lsp.config("pyright", {
                settings = {
                    python = {
                        analysis = {
                            autoSearchPaths = true,
                            diagnosticMode = "workspace",
                            useLibraryCodeForTypes = true,
                        },
                    },
                },
            })

            vim.lsp.config("html", {
                init_options = {
                    configurationSection = { "html", "css", "javascript" },
                    embeddedLanguages = { css = true, javascript = true },
                    provideFormatter = true,
                },
            })

            vim.lsp.config("vimls", {
                diagnostic = { enable = true },
                indexes = {
                    count = 8,
                    gap = 100,
                    projectRootPatterns = { "~/.vim", "nvim" },
                },
                isNeovim = true,
                iskeyword = "@,48-57,_,192-255,-#",
                suggest = { fromRuntimepath = true, fromVimruntime = true },
            })

            vim.lsp.config("jsonls", { init_options = { provideFormatter = true } })

            vim.lsp.config("lua_ls", {
                on_init = function(client)
                    if client.workspace_folders then
                        local path = client.workspace_folders[1].name
                        local has_luarc = vim.uv.fs_stat(path .. "/.luarc.json")
                            or vim.uv.fs_stat(path .. "/.luarc.jsonc")
                        if path ~= vim.fn.stdpath("config") and has_luarc then
                            return
                        end
                    end
                    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                        runtime = { version = "LuaJIT" },
                        workspace = {
                            checkThirdParty = false,
                            library = { vim.env.VIMRUNTIME },
                        },
                    })
                end,
                settings = { Lua = {} },
            })

            vim.lsp.config("texlab", {
                settings = {
                    texlab = {
                        build = {
                            executable = "pdflatex",
                            args = { "-interaction=nonstopmode", "-synctex=1", "%f" },
                            onSave = true,
                            forwardSearchAfter = false,
                        },
                        forwardSearch = {
                            executable = "zathura",
                            args = { "--synctex-forward", "%l:1:%f", "%p" },
                        },
                        chktex = { onEdit = true, onOpenAndSave = true },
                    },
                },
            })

            vim.lsp.enable(lsp_list)
        end,
    },

    {
        "j-hui/fidget.nvim",
        event = "LspAttach",
        opts = {
            notification = { window = { winblend = 0 } },
        },
    },

    {
        "Bekaboo/dropbar.nvim",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = { "nvim-telescope/telescope-fzf-native.nvim" },
        config = function()
            require("dropbar").setup()
            vim.keymap.set("n", "<leader>;", function()
                require("dropbar.api").pick()
            end, { desc = "Pick winbar" })
        end,
    },
}
