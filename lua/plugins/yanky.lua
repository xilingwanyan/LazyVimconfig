
-- better yank/paste
return {
  "gbprod/yanky.nvim",
  keys = {
    {
      "<C-p>",
      function()
        if LazyVim.pick.picker.name == "telescope" then
          require("telescope").extensions.yank_history.yank_history({})
        elseif LazyVim.pick.picker.name == "snacks" then
          Snacks.picker.yanky()
        else
          vim.cmd([[YankyRingHistory]])
        end
      end,
      mode = { "n", "x" },
      desc = "Open Yank History",
    },

    { "<leader>p", '"+p', mode = { "n", "x" }, desc = "Paste from Clipboard" },

  },
}

