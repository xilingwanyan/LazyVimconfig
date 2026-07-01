return {
    "uga-rosa/ccc.nvim",
    keys = {
        { "<leader>ce", "<cmd>CccPick<cr>", desc = "Color Pick" },
    },
    opts = {
        highlighter = {
            auto_enable = false, -- 禁用它的高亮，因为 mini.hipatterns 已经在做了
        },
    },
}
