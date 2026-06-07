-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Always resolve the project root via git, not LSP workspace or directory patterns.
-- LazyVim.root() (used by <C-/> terminal toggle etc.) defaults to { "lsp", { ".git", "lua" }, "cwd" },
-- which can return an intermediate directory (e.g. config/nvim) when a pattern like "lua" fires
-- before ".git". Setting this to { ".git", "cwd" } makes the git root the authoritative root.
vim.g.root_spec = { ".git", "cwd" }
