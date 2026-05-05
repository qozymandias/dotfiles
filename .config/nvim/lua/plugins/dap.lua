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
        version = "^6",
        ft = { "rust" },
        init = function()
            vim.g.rustaceanvim = {
                server = {
                    default_settings = {
                        ["rust-analyzer"] = {
                            cargo = { allFeatures = true },
                            checkOnSave = true,
                            check = {
                                command = "clippy",
                                extraArgs = { "--no-deps", "--", "-Dwarnings" },
                            },
                        },
                    },
                },
            }
        end,
    },
}
