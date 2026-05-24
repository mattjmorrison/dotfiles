return {
  {
    "folke/sidekick.nvim",
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
