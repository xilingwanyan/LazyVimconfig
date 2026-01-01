-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
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
