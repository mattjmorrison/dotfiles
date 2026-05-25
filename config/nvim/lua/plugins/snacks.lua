return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            win = {
              list = {
                keys = {
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
