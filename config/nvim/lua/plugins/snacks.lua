local function move_vertical_from_explorer(direction)
  local current = vim.api.nvim_get_current_win()
  local current_pos = vim.api.nvim_win_get_position(current)
  local current_width = vim.api.nvim_win_get_width(current)
  local current_top = current_pos[1]
  local current_bottom = current_top + vim.api.nvim_win_get_height(current)
  local current_left = current_pos[2]
  local current_right = current_left + current_width
  local target
  local target_distance = math.huge

  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local filetype = vim.bo[vim.api.nvim_win_get_buf(win)].filetype
    local is_snacks_ui = filetype:match("^snacks_") and filetype ~= "snacks_terminal"
    if win ~= current and vim.api.nvim_win_get_config(win).relative == "" and not is_snacks_ui then
      local pos = vim.api.nvim_win_get_position(win)
      local top = pos[1]
      local bottom = top + vim.api.nvim_win_get_height(win)
      local left = pos[2]
      local right = left + vim.api.nvim_win_get_width(win)
      local overlaps_column = left < current_right and right > current_left
      local distance = direction == "down" and top - current_bottom or current_top - bottom

      if overlaps_column and distance >= 0 and distance < target_distance then
        target = win
        target_distance = distance
      end
    end
  end

  if target then
    vim.api.nvim_set_current_win(target)
    return
  end

  require("smart-splits.mux").move_pane(direction, true, "stop")
end

local function terminal_smart_splits_action(key, method)
  return function(self)
    if self:is_floating() then
      return key
    end

    vim.schedule(function()
      require("smart-splits")[method]()
    end)

    return ""
  end
end

return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>gg",
        function()
          Snacks.lazygit()
        end,
        desc = "Open LazyGit",
      },
    },
    opts = {
      lazygit = { enabled = true },
      terminal = {
        win = {
          keys = {
            nav_h = {
              "<C-h>",
              function(self)
                if self:is_floating() then
                  local chan = vim.b[self.buf].terminal_job_id
                  vim.schedule(function()
                    vim.api.nvim_chan_send(chan, "2")
                  end)
                else
                  vim.schedule(function()
                    require("smart-splits").move_cursor_left()
                  end)
                end
                return ""
              end,
              desc = "Go to Left Window",
              expr = true,
              mode = "t",
            },
            nav_j = {
              "<C-j>",
              terminal_smart_splits_action("<C-j>", "move_cursor_down"),
              desc = "Go to Lower Window",
              expr = true,
              mode = "t",
            },
            nav_k = {
              "<C-k>",
              terminal_smart_splits_action("<C-k>", "move_cursor_up"),
              desc = "Go to Upper Window",
              expr = true,
              mode = "t",
            },
            nav_l = {
              "<C-l>",
              terminal_smart_splits_action("<C-l>", "move_cursor_right"),
              desc = "Go to Right Window",
              expr = true,
              mode = "t",
            },
          },
        },
      },
      picker = {
        sources = {
          explorer = {
            win = {
              list = {
                keys = {
                  ["<C-j>"] = function()
                    move_vertical_from_explorer("down")
                  end,
                  ["<C-k>"] = function()
                    move_vertical_from_explorer("up")
                  end,
                  ["w"] = { { "pick_win", "jump" } },
                },
              },
            },
          },
        },
      },
    },
  },
}
