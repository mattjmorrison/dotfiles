return {
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    init = function()
      vim.g.smart_splits_multiplexer_integration = "tmux"
    end,
    opts = {
      default_amount = 3,
      multiplexer_integration = "tmux",
      ignored_filetypes = {
        "neo-tree",
        "NvimTree",
        "snacks_*",
        "snacks_picker_list",
        "snacks_picker_input",
      },
    },
    keys = {
      {
        "<C-h>",
        function()
          require("smart-splits").move_cursor_left()
        end,
        desc = "Move to left pane",
      },
      {
        "<BS>",
        function()
          require("smart-splits").move_cursor_left()
        end,
        desc = "Move to left pane",
      },
      {
        "<C-j>",
        function()
          require("smart-splits").move_cursor_down()
        end,
        desc = "Move to lower pane",
      },
      {
        "<C-k>",
        function()
          require("smart-splits").move_cursor_up()
        end,
        desc = "Move to upper pane",
      },
      {
        "<C-l>",
        function()
          require("smart-splits").move_cursor_right()
        end,
        desc = "Move to right pane",
      },
      {
        "<M-h>",
        function()
          require("smart-splits").resize_left()
        end,
        desc = "Resize left",
      },
      {
        "<M-j>",
        function()
          require("smart-splits").resize_down()
        end,
        desc = "Resize down",
      },
      {
        "<M-k>",
        function()
          require("smart-splits").resize_up()
        end,
        desc = "Resize up",
      },
      {
        "<M-l>",
        function()
          require("smart-splits").resize_right()
        end,
        desc = "Resize right",
      },
    },
  },
}
