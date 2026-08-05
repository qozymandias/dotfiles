return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-telescope/telescope-dap.nvim",
            "jay-babu/mason-nvim-dap.nvim",
        },
        keys = {
            { "<leader>db",  function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
            { "<leader>dbc", function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end, desc = "Conditional breakpoint" },
            { "<leader>dl",  function() require("dap").continue() end, desc = "Launch / continue" },
            { "<leader>dc",  function() require("dap").continue() end, desc = "Continue" },
            { "<leader>dp",  function() require("dap").pause() end, desc = "Pause" },
            { "<leader>dk",  function() require("dap").terminate() end, desc = "Terminate" },
            { "<leader>drr", function() require("dap").restart() end, desc = "Restart" },
            { "<leader>dr",  function() require("dap").disconnect() require("dapui").close() end, desc = "Reset" },
            { "<leader>dst", function() require("dap").step_into() end, desc = "Step into" },
            { "<leader>dso", function() require("dap").step_over() end, desc = "Step over" },
            { "<leader>dsu", function() require("dap").step_out() end, desc = "Step out" },
            { "<leader>drh", function() require("dap").run_to_cursor() end, desc = "Run to cursor" },
            { "<leader>du",  function() require("dap").up() end, desc = "Up frame" },
            { "<leader>dd",  function() require("dap").down() end, desc = "Down frame" },
            { "<leader>de",  function() require("dapui").eval() end, mode = { "n", "v" }, desc = "Eval expression" },
            { "<leader>dw",  function() require("dapui").eval(vim.fn.expand("<cexpr>")) end, desc = "Watch expression" },
            { "<leader>ds",  function() require("telescope").extensions.dap.configurations() end, desc = "DAP configurations" },
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            dapui.setup()
            require("nvim-dap-virtual-text").setup()

            require("mason-nvim-dap").setup({
                ensure_installed = { "python", "codelldb" },
                automatic_installation = true,
            })

            dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
            dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
            dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

            vim.fn.sign_define("DapBreakpoint", { text = "B", texthl = "DiagnosticError" })
            vim.fn.sign_define("DapStopped", { text = ">", texthl = "DiagnosticWarn" })

            pcall(require("telescope").load_extension, "dap")
        end,
    },

    {
        "mrcjkb/rustaceanvim",
        version = "^9",
        ft = { "rust" },
        init = function()
            vim.g.rustaceanvim = {
                server = {
                    default_settings = {
                        ["rust-analyzer"] = {
                            cargo = {
                                allFeatures = true,
                                buildScripts = { enable = true },
                                targetDir = true,
                            },
                            checkOnSave = true,
                            check = {
                                command = "clippy",
                                extraArgs = { "--no-deps", "--", "-Dwarnings" },
                            },
                            procMacro = {
                                enable = true,
                                attributes = { enable = true },
                            },
                            diagnostics = {
                                experimental = { enable = true },
                                disabled = { "unresolved-proc-macro" },
                            },
                            cachePriming = { enable = false },
                            files = {
                                excludeDirs = { "target", "node_modules", ".direnv" },
                            },
                        },
                    },
                    on_attach = function(_, bufnr)
                        vim.keymap.set("n", "<leader>ru", function()
                            local diags = vim.diagnostic.get(0, {
                                severity = { vim.diagnostic.severity.WARN, vim.diagnostic.severity.HINT },
                            })
                            local diag
                            for _, d in ipairs(diags) do
                                local code = d.code or (d.user_data and d.user_data.lsp and d.user_data.lsp.code)
                                if code == "unused_imports" then
                                    diag = d
                                    break
                                end
                            end
                            if not diag then
                                vim.notify("No unused imports detected", vim.log.levels.INFO)
                                return
                            end
                            local params = vim.lsp.util.make_range_params(0, "utf-8")
                            params.range = {
                                start = { line = diag.lnum, character = diag.col },
                                ["end"] = { line = diag.end_lnum or diag.lnum, character = diag.end_col or diag.col },
                            }
                            params.context = { diagnostics = { vim.lsp.diagnostic.from(diag) } }
                            vim.lsp.buf_request(0, "textDocument/codeAction", params, function(err, res, ctx)
                                if err or not res then
                                    vim.notify("No code actions available", vim.log.levels.WARN)
                                    return
                                end
                                for _, action in ipairs(res) do
                                    if action.title and action.title:lower():match("remove all the unused imports") then
                                        local client = vim.lsp.get_client_by_id(ctx.client_id)
                                        if action.edit then
                                            local enc = client and client.offset_encoding or "utf-16"
                                            vim.lsp.util.apply_workspace_edit(action.edit, enc)
                                        end
                                        if action.command then
                                            vim.lsp.buf.execute_command(action.command)
                                        end
                                        vim.notify("Removed unused imports", vim.log.levels.INFO)
                                        return
                                    end
                                end
                                vim.notify("Action 'Remove all the unused imports' not offered", vim.log.levels.WARN)
                            end)
                        end, { buffer = bufnr, desc = "Rust: remove all unused imports" })
                    end,
                },
            }
        end,
    },
}
