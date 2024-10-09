-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Increment/ decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- New tab
keymap.set("n", "te", ":tabedit", opts)
-- Disabled for now because remapping <tab> also messes up <C-i> jump forward
-- keymap.set("n", "<tab>", ":tabnext<Return>", opts)
-- keymap.set("n", "<S-tab>", ":tabprev<Return>", opts)

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><", opts)
keymap.set("n", "<C-w><right>", "<C-w>>", opts)
keymap.set("n", "<C-w><down>", "<C-w>-", opts)
keymap.set("n", "<C-w><up>", "<C-w>+", opts)

-- Diagnostics
keymap.set("n", "<leader>df", function()
  vim.diagnostic.open_float()
end, { desc = "Open floating diagnostic" })

keymap.set("n", "<leader>do", function()
  vim.diagnostic.setloclist()
end, { desc = "Diagnostics quickfix (current buffer)" })

keymap.set("n", "<leader>dO", function()
  vim.diagnostic.setqflist()
end, { desc = "Diagnostics quickfix (all)" })

keymap.set("n", "<leader>dn", function()
  vim.diagnostic.goto_next()
end, { desc = "Go to next diagnostic" })

keymap.set("n", "<leader>dN", function()
  vim.diagnostic.goto_prev()
end, { desc = "Go to previous diagnostic" })
