-- -- Mappings.
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<leader>i', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
--  vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

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
        --cmp.mapping.confirm()
    else
        fallback() -- If you are using vim-endwise, this fallback function will be behaive as the vim-endwise.
    end
end
local tab_next = function(fallback)
    if cmp.visible() then
        cmp.select_next_item()
    elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
        --  elseif cmp.has_words_before() then
        --      cmp.complete()
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
        -- REQUIRED - you must specify a snippet engine
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
    sources = cmp.config.sources({ { name = 'nvim_lsp' }, { name = 'luasnip' }
    }, {
        { name = 'buffer' },
    })
};

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
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

local lsp_path = "/home/centos/.local/share/nvim/lsp_servers/"
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
local flag_args = { debounce_text_changes = 150 }

local lspconfig = require 'lspconfig'
lspconfig.bashls.setup {
    cmd = { lsp_path .. "bashls/node_modules/.bin/bash-language-server" },
    capabilities = capabilities,
    on_attach = on_attach,
    flags = flag_args
}

lspconfig.yamlls.setup {
    cmd = { lsp_path .. "yamlls/node_modules/.bin/yaml-language-server" },
    capabilities = capabilities,
    on_attach = on_attach,
    flags = flag_args
}

lspconfig.pyright.setup {
    cmd = { lsp_path .. "pyright/node_modules/.bin/pyright-langserver" },
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

lspconfig.sumneko_lua.setup {
    projectRootPatterns = { "~/.config", "lua" },
    cmd = { lsp_path .. "sumneko_lua/extension/server/bin/lua-language-server",
        "-E",
        lsp_path .. "sumneko_lua/extension/server/" .. "main.lua" };
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = '/usr/bin/lua',
            },
            diagnostics = {
                enable = true,
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
                neededFileStatus = {
                    ["codestyle-check"] = "Any",
                },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                -- library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
                ignoreDir = { "/home/centos/.local" }
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
            format = {
                enable = true,
            }
        },
    },
    capabilities = capabilities,
    on_attach = on_attach,
    flags = flag_args
}

lspconfig.vimls.setup {
    cmd = { lsp_path .. "vimls/node_modules/.bin/vim-language-server", "--stdio" },
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
    cmd = { lsp_path .. "jsonls/node_modules/.bin/json-language-server" },
    init_options = {
        provideFormatter = true
    },
    capabilities = capabilities,
    on_attach = on_attach,
    flags = flag_args
}

lspconfig.tsserver.setup {
    cmd = { lsp_path .. "tsserver/node_modules/.bin/typescript-language-server", "--stdio" },
    capabilities = capabilities,
    on_attach = on_attach,
    flags = flag_args
}

-- lspconfig.eslint.setup {
--     cmd = { lsp_path .. "eslint/node_modules/.bin/vscode-eslint-language-server", "--stdio" },
--     capabilities = capabilities,
--     on_attach = on_attach,
--     flags = flag_args
-- }

lspconfig.emmet_ls.setup {
    cmd = { lsp_path .. "emmet_ls/node_modules/.bin/emmet_ls", "--stdio" },
    capabilities = capabilities,
    on_attach = on_attach,
    flags = flag_args
}

lspconfig.html.setup {
    cmd = { lsp_path .. "html/node_modules/.bin/vscode-html-language-server", "--stdio" },
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


local lsp_status = require('lsp-status')
lsp_status.register_progress()

local ccls_init = {
    rootPatterns = {
        "../Build/compile_commands.json",
    };
    cache = {
        directory = "../.ccls-cache";
        hierarchicalPath = true;
        retainInMemory = 1;
    };
    compilationDatabaseDirectory = "../Build";
    client = {
        snippetSupport = true
    },
    completion = {
        enableSnippetInsertion = true
    },
    index = {
        threads = 8;
    };
    clang = {
        extraArgs = { "-std=c++17" };
    };
    diagnostics = {
        onChange = 100,
        onSave = 100,
        onOpen = 100
    },
    highlight = { lsRanges = true }
}

local servers = { 'ccls' }
local inits = { ccls_init }
for i, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        --handlers = hs[i],
        init_options = inits[i],
        capabilities = capabilities,
        on_attach = on_attach,
        flags = flag_args
    }
end
