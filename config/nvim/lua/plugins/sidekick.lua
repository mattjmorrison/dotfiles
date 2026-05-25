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
