return {
    "rcarriga/nvim-dap-ui",
    opts = {
        layouts = {
            {
                elements = {
                    {
                        id = "repl",
                        size = 0.5,
                    },
                    {
                        id = "console",
                        size = 0.5,
                    },
                },
                position = "left",
                size = 9999,
            },
            {
                elements = {
                    {
                        id = "scopes",
                        size = 0.5,
                    },
                    {
                        id = "breakpoints",
                        size = 0.5,
                    },
                },
                position = "left",
                size = 9999,
            },
            {
                elements = {
                    {
                        id = "stacks",
                        size = 0.5,
                    },
                    {
                        id = "watches",
                        size = 0.5,
                    },
                },
                position = "left",
                size = 9999,
            },
        },
    },
    config = function(_, opts)
        require("dapui").setup(opts)
    end,
}
