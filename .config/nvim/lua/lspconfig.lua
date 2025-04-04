-- -- Mappings.
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<leader>i', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

local navic = require("nvim-navic")
local on_attach = function(client, bufnr)
    navic.attach(client, bufnr)
end

local cmp = require 'cmp'
local lspkind = require('lspkind')

local confirm_select = function(fallback)
    if cmp.visible() then
        cmp.confirm()
    else
        fallback()
    end
end
local tab_next = function(fallback)
    if cmp.visible() then
        cmp.select_next_item()
    else
        fallback()
    end
end

cmp.setup {
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol',
            maxwidth = 50,
        })
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<tab>'] = tab_next,
        ['<cr>'] = confirm_select,
        ['<C-m>'] = confirm_select,
        -- ['<space>'] = confirm_select,
        -- ['<esc>'] = confirm_select,
        ['<C-e'] = cmp.mapping.abort(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp",
            entry_filter = function(entry, _)
                return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
            end },
    }, {
        { name = 'buffer' },
    })
};

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' },
    }, {
        { name = 'buffer' },
    })
});
-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
});

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
});

require("lsp-colors").setup({
    Error = "#db4b4b",
    Warning = "#e0af68",
    Information = "#0db9d7",
    Hint = "#10B981"
})

vim.cmd [[autocmd! ColorScheme * highlight Function guifg=white guibg=#1f2335]]
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = false,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities()
local flag_args = { debounce_text_changes = 150 }

local lspconfig = require 'lspconfig'

lspconfig.bashls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = flag_args
}

lspconfig.yamlls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = flag_args
}

lspconfig.ts_ls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = flag_args
}

lspconfig.clangd.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = flag_args
}

lspconfig.pyright.setup {
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true
            }
        }
    },
    capabilities = capabilities,
    on_attach = on_attach,
    flags = flag_args
}

lspconfig.vimls.setup {
    diagnostic = {
        enable = true
    },
    indexes = {
        count = 8,
        gap = 100,
        projectRootPatterns = { "~/.vim", "nvim" },
    },
    isNeovim = true,
    iskeyword = "@,48-57,_,192-255,-#",
    suggest = {
        fromRuntimepath = true,
        fromVimruntime = true
    },
    capabilities = capabilities,
    on_attach = on_attach,
    flags = flag_args
}

lspconfig.jsonls.setup {
    init_options = {
        provideFormatter = true
    },
    capabilities = capabilities,
    on_attach = on_attach,
    flags = flag_args
}

lspconfig.rust_analyzer.setup {
    settings = {
        ['rust-analyzer'] = {
            cargo = {
                allFeatures = true,
            },
            checkOnSave = {
                command = "clippy",
                extraArgs = { "--no-deps", "--", "-Dwarnings" },
            },
            diagnostics = {
                enable = false,
            },
            files = {
                excludeDirs = { ".git", "target", "node_modules" },
            },
        }
    },
    capabilities = capabilities,
    on_attach = on_attach,
    flags = flag_args
}

lspconfig.html.setup {
    init_options = {
        configurationSection = { "html", "css", "javascript" },
        embeddedLanguages = {
            css = true,
            javascript = true
        },
        provideFormatter = true
    },
    capabilities = capabilities,
    on_attach = on_attach,
    flags = flag_args
}

require 'lspconfig'.lua_ls.setup {
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc')) then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
                version = 'LuaJIT'
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME
                }
            }
        })
    end,
    settings = {
        Lua = {}
    },
    capabilities = capabilities,
    on_attach = on_attach,
    flags = flag_args
}

function LiveGrepVisualSelection()
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")

    if not start_pos or not end_pos then
        print("No visual selection found")
        return
    end

    local _, ls, cs = unpack(start_pos)
    local _, le, ce = unpack(end_pos)

    if ls == 0 or le == 0 then
        print("Invalid selection")
        return
    end

    local text = vim.api.nvim_buf_get_text(0, ls - 1, cs - 1, le - 1, ce, {})
    local query = table.concat(text, " ")

    if query == "" then
        print("Empty selection")
        return
    end

    require("telescope.builtin").live_grep({ default_text = query })
end

vim.keymap.set("v", "<leader>fg", ":lua LiveGrepVisualSelection()<CR>", { noremap = true, silent = true })
