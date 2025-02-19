-- -- Mappings.
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<leader>i', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

local navic = require("nvim-navic")
local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    navic.attach(client, bufnr)
end

local cmp = require 'cmp'
local luasnip = require 'luasnip'
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
    elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
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
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
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
            entry_filter = function(entry, ctx)
                return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
            end },
    }, {
      { name = 'buffer' },
      { name = 'luasnip' },
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

local lsp_path = "~/.local/share/nvim/lsp_servers/"
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

lspconfig.ts_ls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = flag_args
}

lspconfig.rust_analyzer.setup{
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = false;
      },
      cargo = {
        allFeatures = true,
      },
      checkOnSave = {
        command = "clippy",
        extraArgs = {"--no-deps", "--", "-Dwarnings"},
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

lspconfig.clangd.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = flag_args
}

-- local lsp_status = require('lsp-status')
-- lsp_status.register_progress()
-- local ccls_init = {
--     rootPatterns = {
--         "../Build/linux64_gcc7_debug/compile_commands.json",
--     };
--     cache = {
--         directory = "../.ccls-cache";
--         hierarchicalPath = true;
--         retainInMemory = 1;
--     };
--     compilationDatabaseDirectory = "../Build/linux64_gcc7_debug/";
--     client = {
--         snippetSupport = true
--     },
--     completion = {
--         enableSnippetInsertion = true
--     },
--     index = {
--         threads = 8;
--     };
--     clang = {
--         extraArgs = { "-std=c++17" };
--     };
--     diagnostics = {
--         onChange = 100,
--         onSave = 100,
--         onOpen = 100
--     },
--     highlight = { lsRanges = true }
-- }
-- 
-- local servers = { 'ccls' }
-- local inits = { ccls_init }
-- for i, lsp in ipairs(servers) do
--     lspconfig[lsp].setup {
--         --handlers = hs[i],
--         init_options = inits[i],
--         capabilities = capabilities,
--         on_attach = on_attach,
--         flags = flag_args
--     }
-- end
-- 
-- lspconfig.jdtls.setup {
--     -- cmd = { 'java', },
--     settings = {
--         java = {
--             signatureHelp = { enabled = true },
--             contentProvider = { preferred = 'fernflower' },
--             configuration = {
--                 maven = {
--                     globalSettings = "$HOME/.m2/settings.json",
--                     userSettings = "$HOME/.m2/settings.json",
--                 }
--             },
--             maven = {
--                 downloadSources = true
--             },
--             sources = {
--                 organizeImports = true,
--                 format = { enabled = true }
--             }
--         }
--     },
--     -- java.configuration.maven.globalSettings
--     root_dir = function()
--         return vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1])
--     end,
--     capabilities = capabilities,
--     on_attach = on_attach,
--     flags = flag_args
-- }

-- lspconfig.eslint.setup {
--     capabilities = capabilities,
--     on_attach = on_attach,
--     flags = flag_args
-- }

-- lspconfig.emmet_ls.setup {
--     capabilities = capabilities,
--     on_attach = on_attach,
--     flags = flag_args
-- }

-- lspconfig.sumneko_lua.setup {
--     projectRootPatterns = { "~/.config", "lua" },
--     settings = {
--         Lua = {
--             runtime = {
--                 -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--                 version = 'LuaJIT',
--                 -- Setup your lua path
--                 path = '/usr/bin/lua',
--             },
--             diagnostics = {
--                 enable = true,
--                 -- Get the language server to recognize the `vim` global
--                 globals = { 'vim' },
--                 neededFileStatus = {
--                     ["codestyle-check"] = "Any",
--                 },
--             },
--             workspace = {
--                 -- Make the server aware of Neovim runtime files
--                 -- library = vim.api.nvim_get_runtime_file("", true),
--                 checkThirdParty = false,
--                 ignoreDir = { "~/.local" }
--             },
--             -- Do not send telemetry data containing a randomized but unique identifier
--             telemetry = {
--                 enable = false,
--             },
--             format = {
--                 enable = true,
--             }
--         },
--     },
--     capabilities = capabilities,
--     on_attach = on_attach,
--     flags = flag_args
-- }

