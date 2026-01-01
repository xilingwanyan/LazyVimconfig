-- return {
--     {
--         "folke/noice.nvim",
--         enabled = false,
--     },
-- }
-- return {
--   {
--     "folke/noice.nvim",
--     opts = {
--       cmdline = {
--         enabled = true,
--         view = "cmdline_popup",
--       },
--     },
--   },
-- }
return {
	{
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
	},
}
