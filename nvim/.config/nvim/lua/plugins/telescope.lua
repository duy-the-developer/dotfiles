return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  enabled = function()
    return LazyVim.pick.want() == "telescope"
  end,
  version = false, -- telescope did only one release, so use HEAD for now
  keys = {
    {
      "<leader>,",
      "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
      desc = "Switch Buffer",
    },
    { "<leader>/", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
    { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { "<leader><space>", false }, -- use <leader><space> to save buffer instead
    -- find
    { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
    { "<leader>ff", false }, -- use <leader>sf
    { "<leader>fF", false }, -- use <leader>sF
    { "<leader>fr", "<cmd>Telescope resume<cr>", desc = "Resume" },
    { "<leader>fR", false }, -- use <leader>so
    -- search
    { "<leader>sd", false }, -- use <leader>dO for Trouble diagnostics
    { "<leader>sD", false }, -- use <leader>do for Trouble all diagnostics
    { "<leader>sf", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
    { "<leader>sF", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
    { "<leader>so", "<cmd>Telescope oldfiles<cr>", desc = "Oldfiles" },
    { "<leader>sR", false }, -- use <leader>fr
    { "<leader>sq", false }, -- use <leader>fq for Trouble qfixlist
  },
  opts = function()
    local actions = require("telescope.actions")

    local open_with_trouble = function(...)
      return require("trouble.sources.telescope").open(...)
    end
    local function find_command()
      if 1 == vim.fn.executable("rg") then
        return { "rg", "--files", "--color", "never", "-g", "!.git" }
      elseif 1 == vim.fn.executable("fd") then
        return { "fd", "--type", "f", "--color", "never", "-E", ".git" }
      elseif 1 == vim.fn.executable("fdfind") then
        return { "fdfind", "--type", "f", "--color", "never", "-E", ".git" }
      elseif 1 == vim.fn.executable("find") and vim.fn.has("win32") == 0 then
        return { "find", ".", "-type", "f" }
      elseif 1 == vim.fn.executable("where") then
        return { "where", "/r", ".", "*" }
      end
    end

    return {
      defaults = {
        layout_strategy = "vertical",
        layout_config = {
          height = 0.95,
          width = 0.90,
          prompt_position = "top",
          preview_cutoff = 10,
          mirror = true,
        },
        sorting_strategy = "ascending",
        prompt_prefix = "->",
        selection_caret = " ",
        -- open files in the first window that is an actual file.
        -- use the current window if no other window is available.
        get_selection_window = function()
          local wins = vim.api.nvim_list_wins()
          table.insert(wins, 1, vim.api.nvim_get_current_win())
          for _, win in ipairs(wins) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.bo[buf].buftype == "" then
              return win
            end
          end
          return 0
        end,
        mappings = {
          i = {
            ["<c-q>"] = open_with_trouble,
            ["<a-q>"] = open_with_trouble,
          },
          n = {
            ["q"] = actions.close,
          },
        },
      },
      pickers = {
        find_files = {
          find_command = find_command,
          hidden = true,
        },
      },
    }
  end,
}
