# Neovim Configuration

This repo manages Neovim with Home Manager and a LazyVim-based config.

## Where It Lives

```text
config/nvim/
├── init.lua
├── lua/config/
└── lua/plugins/
```

Home Manager links this directory into place:

```text
config/nvim -> ~/.config/nvim
```

The link is defined in:

```text
modules/home/neovim.nix
```

That module also installs the command-line tools Neovim relies on:

- `neovim`
- `ripgrep`
- `fd`
- `tree-sitter`
- `nodejs`
- `gcc`
- `unzip`
- `wget`
- `marksman`
- `markdownlint-cli2`
- `markdown-toc`

Markdown linting is configured at the repo root in:

```text
.markdownlint-cli2.yaml
```

That config sets `MD013` line length to 200 characters.

## Startup Flow

Neovim starts at:

```text
config/nvim/init.lua
```

That file only loads:

```lua
require("config.lazy")
```

The actual LazyVim bootstrapping happens in:

```text
config/nvim/lua/config/lazy.lua
```

That file:

- installs `lazy.nvim` if it is missing
- adds `lazy.nvim` to the runtime path
- loads LazyVim's default plugin set with `LazyVim/LazyVim`
- imports local plugin specs from `config/nvim/lua/plugins/`
- enables Lazy's update checker without notifications
- disables a few built-in runtime plugins such as `gzip`, `tarPlugin`, `tohtml`, `tutor`, and `zipPlugin`

## Local Config Files

### `lua/config/options.lua`

Reserved for local Neovim options.

This file currently only contains LazyVim's generated comments, so the config is using LazyVim defaults.

### `lua/config/keymaps.lua`

Reserved for local keymaps.

This file currently only contains LazyVim's generated comments. Custom keymaps are currently defined in plugin specs instead.

## Custom Keymaps

These are the custom keymaps currently defined by files in `config/nvim/lua/plugins/`.

| Key | Mode | Defined In | Behavior |
| --- | --- | --- | --- |
| `<leader>gg` | Normal | `lazygit.lua` | Opens LazyGit with `:LazyGit` |
| `<leader>ai` | Normal | `sidekick.lua` | Toggles the Sidekick CLI window |
| `<leader>mp` | Normal, Markdown buffers | `markdown.lua` | Toggles Markdown Preview |
| `<C-h>` | Snacks terminal | `snacks.lua` | Moves to the left Neovim split or tmux pane from the terminal |
| `<C-j>` | Snacks terminal | `snacks.lua` | Moves to the lower Neovim split or tmux pane from the terminal |
| `<C-k>` | Snacks terminal | `snacks.lua` | Moves to the upper Neovim split or tmux pane from the terminal |
| `<C-l>` | Snacks terminal | `snacks.lua` | Moves to the right Neovim split or tmux pane from the terminal |
| `w` | Snacks explorer list | `snacks.lua` | Runs Snacks explorer's `pick_win` action, then `jump` |
| `<C-j>` | Snacks explorer list | `snacks.lua` | Moves to the lower Neovim split or tmux pane via smart-splits |
| `<C-k>` | Snacks explorer list | `snacks.lua` | Moves to the upper Neovim split or tmux pane via smart-splits |
| `<C-h>` | Normal | `smart-splits.lua` | Moves to the left Neovim split or tmux pane |
| `<BS>` | Normal | `smart-splits.lua` | Moves to the left Neovim split or tmux pane |
| `<C-j>` | Normal | `smart-splits.lua` | Moves to the lower Neovim split or tmux pane |
| `<C-k>` | Normal | `smart-splits.lua` | Moves to the upper Neovim split or tmux pane |
| `<C-l>` | Normal | `smart-splits.lua` | Moves to the right Neovim split or tmux pane |
| `<M-h>` | Normal | `smart-splits.lua` | Resizes the current pane left |
| `<M-j>` | Normal | `smart-splits.lua` | Resizes the current pane down |
| `<M-k>` | Normal | `smart-splits.lua` | Resizes the current pane up |
| `<M-l>` | Normal | `smart-splits.lua` | Resizes the current pane right |

### `lua/config/autocmds.lua`

Reserved for local autocommands.

This file currently only contains LazyVim's generated comments. Plugin-specific autocommands live in their plugin specs when needed.

## Plugin Specs

Every Lua file in `config/nvim/lua/plugins/` is loaded by Lazy.

### `colorscheme.lua`

Configures LazyVim to use:

```text
tokyonight-night
```

This file does not define custom keymaps.

### `dashboard.lua`

Customizes the Snacks dashboard.

Current behavior:

- defines dashboard highlight groups for a Rubik's-cube-style header
- replaces the dashboard sections with the custom header, key list, and startup summary

This file does not define custom keymaps.

### `lazygit.lua`

Adds:

- `kdheepak/lazygit.nvim`
- dependency: `nvim-lua/plenary.nvim`

Commands registered:

- `LazyGit`
- `LazyGitConfig`
- `LazyGitCurrentFile`
- `LazyGitFilter`
- `LazyGitFilterCurrentFile`

Keymap:

```text
<leader>gg -> LazyGit
```

### `sidekick.lua`

Configures:

- `folke/sidekick.nvim`

Current behavior:

- disables Sidekick's mux integration
- configures the Claude CLI command as `claude`
- disables Sidekick NES
- routes Sidekick terminal `Ctrl-h/j/k/l` navigation and `Option-h/j/k/l` resizing through smart-splits so edge actions can leave Neovim for tmux

Keymap:

```text
<leader>ai -> toggle Sidekick CLI
```

### `markdown.lua`

Configures:

- `iamcco/markdown-preview.nvim`

Current behavior:

- disables LazyVim's default `<leader>cp` Markdown preview mapping
- maps `<leader>mp` in Markdown buffers to `MarkdownPreviewToggle`

### `snacks.lua`

Configures:

- `folke/snacks.nvim`

Current behavior:

- customizes Snacks terminal navigation
- customizes the Snacks picker explorer source
- maps `w` inside the explorer list to run `pick_win`, then `jump`
- maps `Ctrl-j` and `Ctrl-k` inside the explorer list through smart-splits, so Neovim splits take priority before tmux panes

Terminal keymaps:

```text
Ctrl-h -> move to left Neovim split or tmux pane from a non-floating terminal
Ctrl-j -> move to lower Neovim split or tmux pane from a non-floating terminal
Ctrl-k -> move to upper Neovim split or tmux pane from a non-floating terminal
Ctrl-l -> move to right Neovim split or tmux pane from a non-floating terminal
```

Floating Snacks terminals keep the original terminal key input instead of routing through smart-splits.

Explorer list keymap:

```text
w -> pick window, then jump
Ctrl-j -> move to lower Neovim split or tmux pane from the explorer
Ctrl-k -> move to upper Neovim split or tmux pane from the explorer
```

### `smart-splits.lua`

Adds:

- `mrjones2014/smart-splits.nvim`

This plugin coordinates pane movement and resizing between Neovim splits and tmux panes.

Movement keymaps:

```text
Ctrl-h / Backspace -> move left
Ctrl-j             -> move down
Ctrl-k             -> move up
Ctrl-l             -> move right
```

Resize keymaps:

```text
Option-h -> resize left
Option-j -> resize down
Option-k -> resize up
Option-l -> resize right
```

Inside Neovim, smart-splits first tries to act on Neovim windows. When there is no Neovim window in that direction, the plugin asks tmux to move or resize the adjacent tmux pane.

### `example.lua`

This is the generated LazyVim example file.

It currently returns an empty spec immediately:

```lua
if true then return {} end
```

So it documents examples but does not configure anything.

Any keymaps shown inside this file are inactive because the file returns before those specs are loaded.

## Tmux Integration

The Neovim navigation behavior depends on the tmux config in:

```text
config/tmux/tmux.conf
```

The relevant tmux behavior is:

- tmux prefix is `Ctrl-Space`
- mouse support is enabled
- tmux copy/status keys use vi mode
- `Ctrl-Space` then `\` creates a side-by-side split
- `Ctrl-Space` then `-` creates a top/bottom split
- `Ctrl-h/j/k/l` switches tmux panes when the active pane is not Vim/Neovim
- when the active pane is Vim/Neovim, tmux sends `Ctrl-h/j/k/l` through to Neovim
- `Option-h/j/k/l` resizes tmux panes when the active pane is not Vim/Neovim
- when the active pane is Vim/Neovim, tmux sends `Option-h/j/k/l` through to Neovim

Smart-splits sets the tmux `@pane-is-vim` variable when Neovim is active. That is what lets tmux decide whether to handle a key itself or pass it through to Neovim.

## Adding New Plugins

Add a new file under:

```text
config/nvim/lua/plugins/
```

Use the existing plugin specs as the local pattern:

```lua
return {
  {
    "owner/plugin.nvim",
    opts = {},
    keys = {
      { "<leader>x", "<cmd>SomeCommand<cr>", desc = "Do something" },
    },
  },
}
```

## Tests

Neovim-only movement tests live under:

```text
config/nvim/tests/
```

Run them through the Makefile so the repo-local XDG paths are used:

```sh
make test-nvim
```

Tmux-backed integration tests live under:

```text
tests/integration/
```

Run them with:

```sh
make test-tmux-nvim
```

Prefer one plugin or feature area per file. That keeps each plugin's behavior easy to find and remove.

## Applying Changes

Because Home Manager links `config/nvim` to `~/.config/nvim`, most Neovim Lua changes are available after restarting Neovim or reloading Lazy.

If the link itself changes, rebuild the Home Manager/nix-darwin configuration:

```sh
darwin-rebuild switch --flake .#macbook
```
