-- -- Mappings.
-- -- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<leader>i', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
--  vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr',        '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>fo', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local cmp = require 'cmp'

local confirm_select = function(fallback)
    if cmp.visible() then
        cmp.confirm()
    else
        fallback() -- If you are using vim-endwise, this fallback function will be behaive as the vim-endwise.
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
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
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
        { name = 'nvim_lsp' },
        { name = 'vsnip' }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
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

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
local flag_args = { debounce_text_changes = 150 }

local lspconfig = require 'lspconfig'
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

lspconfig.bashls.setup {
    cmd = { "/home/centos/.local/share/nvim/lsp_servers/bashls/node_modules/.bin/bash-language-server" },
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

lspconfig.sumneko_lua.setup {
    cmd = { "/home/centos/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/bin/lua-language-server", "-E", "/home/centos/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/" .. "/main.lua" };
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = '/usr/bin/lua',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
    capabilities = capabilities,
    on_attach = on_attach,
    flags = flag_args
}


lspconfig.vimls.setup {
    cmd = { "/home/centos/.local/share/nvim/lsp_servers/vimls/node_modules/.bin/vim-language-server", "--stdio" },
    diagnostic = {
        enable = true
    },
    indexes = {
        count = 8,
        gap = 100,
        projectRootPatterns = { "~/.vim", "nvim" },
        -- runtimepath = true
    },
    isNeovim = true,
    iskeyword = "@,48-57,_,192-255,-#",
    -- runtimepath =  "",
    suggest = {
        fromRuntimepath = true,
        fromVimruntime = true
    },
    capabilities = capabilities,
    on_attach = on_attach,
    flags = flag_args
}

local lsp_status = require('lsp-status')
lsp_status.register_progress()

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
