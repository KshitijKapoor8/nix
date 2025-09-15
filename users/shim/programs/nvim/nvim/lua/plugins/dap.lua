return {
    "mfussenegger/nvim-dap",
    keys = {
        { "<leader>do", function () require('dap').step_over() end, desc = "Step over" },
        { "<leader>dO", function () require('dap').step_out() end, desc = "Step over" },
        { "<leader>dc", function () require('dap').run_to_cursor() end, desc = "Step over" },
        { "<leader>dc", function () require('dap').continue() end, desc = "Step over" },
    }
}
