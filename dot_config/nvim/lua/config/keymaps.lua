-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>bs", "<cmd>w<cr>", { desc = "Save buffer" })
vim.keymap.set("n", "<leader>bS", "<cmd>wa<cr>", { desc = "Save all buffers" })

-- disable fast window navigation
vim.keymap.del("n", "<C-h>")
vim.keymap.del("n", "<C-j>")
vim.keymap.del("n", "<C-k>")
vim.keymap.del("n", "<C-l>")

-- Move to window using the <ctrl> hjkl keys
vim.keymap.set("n", "<C-Left>", "<C-w>h", { desc = "Go to Left Window", remap = true })
vim.keymap.set("n", "<C-Down>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
vim.keymap.set("n", "<C-Up>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
vim.keymap.set("n", "<C-Right>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
-- map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
-- map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
-- map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
-- map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- use c-j and c-k for scrolling in dropdowns
-- vim.keymap.set("c", "<c-j>", "<c-n>")
-- vim.keymap.set("c", "<c-k>", "<c-p>")

-- preserve search direction when searching
-- vim.keymap.del("n", "n")
-- vim.keymap.del("n", "N")

-- qwerty-fr keybindings
vim.keymap.set("n", "ÿ", "<a-h>", { remap = true })
vim.keymap.set("n", "ì", "<a-i>", { remap = true })

-- vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])
