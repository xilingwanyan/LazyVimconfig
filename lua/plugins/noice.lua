return {
    "folke/noice.nvim",
    opts = {
        cmdline = {
            view = "cmdline_popup",
        },
        views = {
            cmdline_popup = {
                position = {
                    row = -1,
                    col = 0,
                },
                size = {
                    min_width = 0,
                },
                border = {
                    style = "none",
                },
                win_options = {
                    winhighlight = { Normal = "CursorLine" },
                },
            },
        },
	},
}

