return {
    "RaafatTurki/hex.nvim",
    keys = {
        {
            "<leader>bt",
            function()
                require("hex").toggle()
            end,
            mode = "n",
            desc = "switch back and forth",
        },
    },
}
