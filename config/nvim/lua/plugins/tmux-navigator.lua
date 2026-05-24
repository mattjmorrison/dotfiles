return {
  {
    "christoomey/vim-tmux-navigator",
    init = function()
      local function select_tmux_pane_left()
        if vim.env.TMUX then
          vim.system({ "tmux", "select-pane", "-L" })
        end
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "neo-tree",
          "NvimTree",
          "snacks_*",
          "snacks_picker_list",
          "snacks_picker_input",
        },
        callback = function(event)
          vim.keymap.set("n", "<C-h>", select_tmux_pane_left, {
            buffer = event.buf,
            desc = "Move to left tmux pane",
            silent = true,
          })
          vim.keymap.set("n", "<BS>", select_tmux_pane_left, {
            buffer = event.buf,
            desc = "Move to left tmux pane",
            silent = true,
          })
        end,
      })
    end,
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Move to left pane" },
      { "<BS>", "<cmd>TmuxNavigateLeft<cr>", desc = "Move to left pane" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Move to lower pane" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Move to upper pane" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Move to right pane" },
    },
  },
}
