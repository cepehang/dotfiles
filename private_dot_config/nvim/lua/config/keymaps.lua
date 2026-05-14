-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- vim.keymap.set("n", "<leader>bs", "<cmd>w<cr>", { desc = "Save buffer" })
-- vim.keymap.set("n", "<leader>bS", "<cmd>wa<cr>", { desc = "Save all buffers" })

-- disable fast window navigation
vim.keymap.del("n", "<c-h>")
vim.keymap.del("n", "<c-j>")
vim.keymap.del("n", "<c-k>")
vim.keymap.del("n", "<c-l>")

-- use c-j and c-k for scrolling in dropdowns
vim.keymap.set("c", "<c-j>", "<c-n>")
vim.keymap.set("c", "<c-k>", "<c-p>")

-- preserve search direction when scrolling
vim.keymap.del("n", "n")
vim.keymap.del("n", "N")

-- qwerty-fr keybindings
vim.keymap.set("n", "ÿ", "<a-h>", { remap = true })
vim.keymap.set("n", "ì", "<a-i>", { remap = true })

-- vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])
