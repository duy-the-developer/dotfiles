local max_name_length = 50
local function format_path(path)
  -- Split the path into components
  local components = {}
  for component in string.gmatch(path, "[^/]+") do
    table.insert(components, component)
  end

  local length = #components
  local formatted = ""

  if length > 3 then
    -- If more than 2 parents, replace with "../"
    formatted = "../"
    -- Add the first letter of the last two directories
    formatted = formatted .. components[length - 2]:sub(1, 2) .. "/" .. components[length - 1]:sub(1, 2) .. "/"
  else
    -- Add the first letter of each parent directory
    for i = 1, length - 1 do
      formatted = formatted .. components[i]:sub(1, 2) .. "/"
    end
  end

  -- Append the full filename
  formatted = formatted .. components[length]

  if #formatted > max_name_length then
    return "..." .. formatted:sub(-max_name_length + 3)
  else
    return formatted
  end
end

return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
    { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
    { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
    { "<leader>bl", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
    { "<leader>bh", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    { "<S-left>", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
    { "<S-right>", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
  },
  opts = {
    options = {
      always_show_bufferline = true,
      name_formatter = function(buffer)
        if buffer.path == "" then
          return
        else
          return format_path(buffer.path)
        end
      end,
      max_name_length = max_name_length,
      show_duplicate_prefix = false,
    },
  },
}
