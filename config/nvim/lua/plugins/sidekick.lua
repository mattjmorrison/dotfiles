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
