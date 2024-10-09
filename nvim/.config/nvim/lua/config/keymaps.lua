-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- *** DISABLE DEFAULT KEYMAPS ***
local unmap = keymap.del
local unmapOpt = { hidden = true }
---- Buffers
unmap("n", "[b", unmapOpt)
unmap("n", "]b", unmapOpt)
unmap("n", "<leader>bb", unmapOpt) -- bro just use <C-6>
unmap("n", "<leader>`", unmapOpt) -- bro just use <C-6>
---- Windows
unmap("n", "<leader>-", unmapOpt)
unmap("n", "<leader>|", unmapOpt)
---- Redraw
unmap("n", "<leader>ur", unmapOpt) -- why is this needed?
---- Diagnostics
unmap("n", "<leader>xl", unmapOpt)
unmap("n", "<leader>xq", unmapOpt)
unmap("n", "<leader>cd", unmapOpt)
---- Rename
-- unmap("n", "<leader>cr", unmapOpt) -- why is this throwing an error? The keymap exists!

-- *** PERSONAL KEYMAPS ***
---- Increment/ decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

---- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

---- New tab
keymap.set("n", "te", ":tabedit", opts)
---- Disabled for now because remapping <tab> also messes up <C-i> jump forward
---- keymap.set("n", "<tab>", ":tabnext<Return>", opts)
---- keymap.set("n", "<S-tab>", ":tabprev<Return>", opts)

---- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)
keymap.set("n", "sd", function() -- :q if there's more than 1 window
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
  if num_windows > 1 then
    vim.cmd("q")
  else
    require("noice").notify("Cannot close last window, are you trying to quit (:q)?", "error")
  end
end, opts)
-- Example commit

---- Diagnostics
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

---- Code actions
keymap.set("n", "<leader>rn", function()
  vim.lsp.buf.rename()
end, {
  desc = "Rename symbol",
})
