return {
  {
    "iamcco/markdown-preview.nvim",
    keys = {
      { "<leader>cp", false },
      {
        "<leader>mp",
        ft = "markdown",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview",
      },
    },
  },
}
