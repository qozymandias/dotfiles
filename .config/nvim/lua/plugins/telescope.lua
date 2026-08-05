return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        keys = {
            { "<leader>hh", "<cmd>Telescope search_history<cr>", desc = "Search history" },
            { "<leader>h/", "<cmd>Telescope resume<cr>", desc = "Resume" },
            { "<leader>h//", "<cmd>Telescope pickers<cr>", desc = "Pickers" },
            { "<leader>c", "<cmd>Telescope command_history<cr>", desc = "Command history" },
            { "<leader>m", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
            { "<leader>?", "<cmd>Telescope find_files<cr>", desc = "Find files" },
            { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
            { "<leader>r", "<cmd>Telescope registers<cr>", desc = "Registers" },
            { "<leader>gt", "<cmd>Telescope git_status<cr>", desc = "Git status" },
            {
                "<leader>gf",
                function()
                    local cwd = vim.fn.getcwd()
                    local tracked = vim.fn.systemlist({ "git", "-C", cwd, "diff", "--name-only", "HEAD" })
                    if vim.v.shell_error ~= 0 then
                        vim.notify("Not a git repo or git failed", vim.log.levels.WARN)
                        return
                    end
                    local untracked = vim.fn.systemlist({
                        "git", "-C", cwd, "ls-files", "--others", "--exclude-standard",
                    })
                    local files, seen = {}, {}
                    for _, list in ipairs({ tracked, untracked }) do
                        for _, f in ipairs(list) do
                            if f ~= "" and not seen[f] then
                                files[#files + 1] = f
                                seen[f] = true
                            end
                        end
                    end
                    if #files == 0 then
                        vim.notify("No modified files", vim.log.levels.INFO)
                        return
                    end
                    local pickers = require("telescope.pickers")
                    local finders = require("telescope.finders")
                    local conf = require("telescope.config").values
                    local make_entry = require("telescope.make_entry")
                    pickers.new({}, {
                        prompt_title = "Git Modified Files",
                        finder = finders.new_table({
                            results = files,
                            entry_maker = make_entry.gen_from_file({ cwd = cwd }),
                        }),
                        sorter = conf.file_sorter({}),
                        previewer = conf.file_previewer({}),
                    }):find()
                end,
                desc = "Git modified files",
            },
            { "<leader>tg", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
            { "gd", "<cmd>Telescope lsp_definitions<cr>", desc = "LSP definitions" },
            { "gi", "<cmd>Telescope lsp_implementations<cr>", desc = "LSP implementations" },
            { "gr", "<cmd>Telescope lsp_references<cr>", desc = "LSP references" },
            { "<leader>sw", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "LSP workspace symbols" },
            { "<leader>sd", "<cmd>Telescope lsp_document_symbols<cr>", desc = "LSP document symbols" },
            {
                "<leader>fg",
                mode = "v",
                function()
                    local saved = vim.fn.getreg("v")
                    vim.cmd('noau normal! "vy"')
                    local query = vim.fn.getreg("v")
                    vim.fn.setreg("v", saved)
                    if query == nil or query == "" then
                        return
                    end
                    require("telescope.builtin").live_grep({ default_text = query:gsub("\n", " ") })
                end,
                desc = "Grep visual selection",
            },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            "nvim-telescope/telescope-frecency.nvim",
        },
        config = function()
            local previewers = require("telescope.previewers")
            local actions_state = require("telescope.actions.state")
            local actions = require("telescope.actions")

            local _bad = { "package-lock.*", "node_modules", ".*%.txt", ".*%.csv", "*conan*" }
            local function bad_files(filepath)
                for _, v in ipairs(_bad) do
                    if filepath:match(v) then
                        return false
                    end
                end
                return true
            end

            local new_maker = function(filepath, bufnr, opts)
                opts = opts or {}
                if opts.use_ft_detect == nil then
                    opts.use_ft_detect = true
                end
                opts.use_ft_detect = opts.use_ft_detect == false and false or bad_files(filepath)
                previewers.buffer_previewer_maker(filepath, bufnr, opts)
            end

            local multiopen = function(prompt_bufnr)
                local picker = actions_state.get_current_picker(prompt_bufnr)
                local multi = picker:get_multi_selection()
                if vim.tbl_isempty(multi) then
                    actions.select_default(prompt_bufnr)
                    return
                end
                actions.close(prompt_bufnr)
                for _, entry in pairs(multi) do
                    local filename = entry.filename or entry.value
                    local lnum = entry.lnum or 1
                    local lcol = entry.col or 1
                    if filename then
                        vim.cmd(string.format("tabnew +%d %s", lnum, filename))
                        vim.cmd(string.format("normal! %dG%d|", lnum, lcol))
                    end
                end
            end

            require("telescope").setup({
                defaults = {
                    dynamic_preview_title = true,
                    prompt_prefix = "  ",
                    selection_caret = " ",
                    mappings = {
                        i = { ["<C-t>"] = multiopen },
                        n = { ["<C-t>"] = multiopen },
                    },
                    vimgrep_arguments = {
                        "rg", "--no-heading", "--with-filename",
                        "--line-number", "--column", "--smart-case",
                        "--ignore",
                        "--glob", "!**/Cargo.lock",
                        "--glob", "!**/package-lock.json",
                        "--glob", "!**/*.d.ts",
                        "--glob", "!**/*.inactive",
                        "--glob", "!**/*.xcscheme",
                        "--glob", "!**/*.pbxproj",
                    },
                    buffer_previewer_maker = new_maker,
                    entry_prefix = " ",
                    initial_mode = "insert",
                    selection_strategy = "closest",
                    sorting_strategy = "ascending",
                    layout_strategy = "horizontal",
                    layout_config = {
                        horizontal = {
                            prompt_position = "top",
                            preview_width = 0.7,
                            results_width = 0.3,
                        },
                        vertical = { mirror = false },
                        width = 0.87,
                        height = 0.80,
                        preview_cutoff = 120,
                    },
                    file_sorter = require("telescope.sorters").get_fuzzy_file,
                    file_ignore_patterns = _bad,
                    generic_sorter = require("telescope.sorters").get_fuzzy_with_index_bias,
                    path_display = { "smart" },
                    winblend = 0,
                    border = {},
                    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                    color_devicons = true,
                    use_less = true,
                    set_env = { COLORTERM = "truecolor" },
                    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
                    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
                    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
                    cache_picker = {
                        num_pickers = 128,
                        limit_entries = 1000,
                        ignore_empty_prompt = false,
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                },
            })

            pcall(require("telescope").load_extension, "fzf")
            pcall(require("telescope").load_extension, "file_browser")
            pcall(require("telescope").load_extension, "frecency")
        end,
    },
}
