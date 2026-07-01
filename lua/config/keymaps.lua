vim.keymap.set("n", "<leader>ww", "<cmd>w<CR>", { desc = "Save File" })

vim.keymap.set("n", "<leader><Right>", "zL", { desc = "Scroll Right Half Screen" })
vim.keymap.set("n", "<leader><Left>", "zH", { desc = "Scroll Left Half Screen" })

vim.keymap.set("v", "<leader><Right>", "zL", { desc = "Scroll Right Half Screen" })
vim.keymap.set("v", "<leader><Left>", "zH", { desc = "Scroll Left Half Screen" })

vim.keymap.set("n", "<leader>/", "<cmd>noh<CR>", { desc = "Clear Highlight" })

vim.keymap.set("n", "<leader>+", "<RightMouse>", { noremap = true, silent = true })
vim.keymap.set("v", "<leader>+", "<RightMouse>", { noremap = true, silent = true })

vim.keymap.set("v", "<leader>y", '"+y', { desc = "Copy to Clipboard" })
vim.keymap.set("n", "<leader>yy", '"+yy', { desc = "Copy Line to Clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Copy to Clipboard" })
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste from Clipboard" })
vim.keymap.set("n", "<leader>P", '"+P', { desc = "Paste from Clipboard" })

vim.keymap.set("n", "<leader>tw", "<cmd>tabnew<CR>", { desc = "tab nww" })
vim.keymap.set("n", "<leader>t<Left>", "<cmd>tabp<CR>", { desc = "tab previous" })
vim.keymap.set("n", "<leader>t<Right>", "<cmd>tabn<CR>", { desc = "tab next" })
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "tab previous" })
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "tab next" })
vim.keymap.set("n", "<leader>td", "<cmd>tabc<CR>", { desc = "tab close" })
vim.keymap.set("n", "<leader>tc", "<cmd>tabc<CR>", { desc = "tab close" })

vim.keymap.set("n", "<leader>bw", "<cmd>enew<CR>", { desc = "buffer new" })
vim.keymap.set("n", "<leader>b<Left>", "<cmd>bp<CR>", { desc = "buffer pervious" })
vim.keymap.set("n", "<leader>b<Right>", "<cmd>bn<CR>", { desc = "buffer next" })
vim.keymap.set("n", "<leader>bp", "<cmd>bp<CR>", { desc = "buffer pervious" })
vim.keymap.set("n", "<leader>bn", "<cmd>bn<CR>", { desc = "buffer next" })

vim.keymap.set("n", "<leader>di1", function ()
    require("dapui").open({layout = 1})
end, { desc = "part 1 of the dapui" })
vim.keymap.set("n", "<leader>di2", function ()
    require("dapui").open({layout = 2})
end, { desc = "part 2 of the dapui" })
vim.keymap.set("n", "<leader>di3", function ()
    require("dapui").open({layout = 3})
end, { desc = "part 3 of the dapui" })


vim.keymap.set("n", "<leader>dio", function()
    vim.cmd.tabnew()
    vim.cmd.tabnew()
    vim.cmd.tabnew()
    local buf3 =  vim.api.nvim_get_current_buf()
    require("dapui").open({layout = 3})
    vim.cmd.wincmd("h")
    vim.api.nvim_set_option_value("buflisted", true, { buf = 0 })
    vim.api.nvim_buf_delete(
       buf3,
        {unload = true}
    )
    vim.cmd.tabprevious()
    local buf2 =  vim.api.nvim_get_current_buf()
    require("dapui").open({layout = 2})
    vim.cmd.wincmd("h")
    vim.api.nvim_set_option_value("buflisted", true, { buf = 0 })
    vim.api.nvim_buf_delete(
        buf2,
        {unload = true}
    )
    vim.cmd.tabprevious()
    local buf1 =  vim.api.nvim_get_current_buf()
    require("dapui").open({layout = 1})
    vim.cmd.wincmd("h")
    vim.api.nvim_set_option_value("buflisted", true, { buf = 0 })
    vim.api.nvim_buf_delete(
        buf1,
        {unload = true}
    )
end, { desc = "depui open" })
