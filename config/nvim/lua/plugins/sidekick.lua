local function smart_splits_action(method)
  return function()
    vim.schedule(function()
      require("smart-splits")[method]()
    end)
    return ""
  end
end

return {
  {
    "folke/sidekick.nvim",
    config = function()
      require("sidekick").setup({})
      local saved_mouse = nil
      -- this is really only NEEDED for windows
      vim.api.nvim_create_autocmd("WinEnter", {
        callback = function()
          if vim.bo.filetype == "sidekick_termianl" then
            saved_mouse = vim.o.mouse
            vim.o.mouse = ""
          end
        end,
      })
      -- this is really only NEEDED for windows
      vim.api.nvim_create_autocmd("WinLeave", {
        callback = function()
          if vim.bo.filetype == "sidekick_terminal" and saved_mouse ~= nil then
            vim.o.mouse = saved_mouse
            saved_mouse = nil
          end
        end,
      })
    end,
    keys = {
      {
        "<leader>ai",
        function()
          require("sidekick.cli").toggle()
        end,
        desc = "Sidekick Show CLI",
      },
    },
    opts = {
      cli = {
        win = {
          keys = {
            nav_left = {
              "<c-h>",
              smart_splits_action("move_cursor_left"),
              expr = true,
              desc = "Navigate left",
            },
            nav_down = {
              "<c-j>",
              smart_splits_action("move_cursor_down"),
              expr = true,
              desc = "Navigate down",
            },
            nav_up = {
              "<c-k>",
              smart_splits_action("move_cursor_up"),
              expr = true,
              desc = "Navigate up",
            },
            nav_right = {
              "<c-l>",
              smart_splits_action("move_cursor_right"),
              expr = true,
              desc = "Navigate right",
            },
            resize_left = {
              "<M-h>",
              smart_splits_action("resize_left"),
              expr = true,
              desc = "Resize left",
            },
            resize_down = {
              "<M-j>",
              smart_splits_action("resize_down"),
              expr = true,
              desc = "Resize down",
            },
            resize_up = {
              "<M-k>",
              smart_splits_action("resize_up"),
              expr = true,
              desc = "Resize up",
            },
            resize_right = {
              "<M-l>",
              smart_splits_action("resize_right"),
              expr = true,
              desc = "Resize right",
            },
          },
        },
        mux = {
          enabled = false,
        },
        tools = {
          claude = {
            cmd = { "claude" },
          },
        },
      },
      nes = {
        enabled = false,
      },
    },
  },
}
