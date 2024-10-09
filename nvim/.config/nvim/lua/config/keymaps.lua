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
keymap.set("n", "sd", function()
  local function count_buffer_windows()
    local count = 0
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local config = vim.api.nvim_win_get_config(win)
      if not config.relative or config.relative == "" then
        count = count + 1
      end
    end
    return count
  end
  local num_windows = count_buffer_windows()
  print(num_windows)
  if num_windows > 1 then
    vim.cmd("q")
  end
end, opts)

-- Delete default keymaps
---- Buffers
keymap.del("n", "[b")
keymap.del("n", "]b")
keymap.del("n", "<leader>bb") -- bro just use <C-6>
keymap.del("n", "<leader>`") -- bro just use <C-6>
---- Windows
keymap.del("n", "<leader>-")
keymap.del("n", "<leader>|")
---- Redraw
keymap.del("n", "<leader>ur") -- why is this needed?
---- Diagnostics
keymap.del("n", "<leader>xl")
keymap.del("n", "<leader>xq")
keymap.del("n", "<leader>cd")

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
