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
| `w` | Snacks explorer list | `snacks.lua` | Runs Snacks explorer's `pick_win` action, then `jump` |
| `<C-h>` | Normal | `tmux-navigator.lua` | Moves to the left Neovim split or tmux pane |
| `<BS>` | Normal | `tmux-navigator.lua` | Moves to the left Neovim split or tmux pane |
| `<C-j>` | Normal | `tmux-navigator.lua` | Moves to the lower Neovim split or tmux pane |
| `<C-k>` | Normal | `tmux-navigator.lua` | Moves to the upper Neovim split or tmux pane |
| `<C-l>` | Normal | `tmux-navigator.lua` | Moves to the right Neovim split or tmux pane |

Explorer-like buffers also get buffer-local overrides for `<C-h>` and `<BS>` so left movement goes directly to the left tmux pane. That override applies to:

- `neo-tree`
- `NvimTree`
- `snacks_*`
- `snacks_picker_list`
- `snacks_picker_input`

### `lua/config/autocmds.lua`

Reserved for local autocommands.

This file currently only contains LazyVim's generated comments. The tmux navigator plugin defines its own targeted autocommand in its plugin spec.

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

Keymap:

```text
<leader>ai -> toggle Sidekick CLI
```

### `snacks.lua`

Configures:

- `folke/snacks.nvim`

Current behavior:

- customizes the Snacks picker explorer source
- maps `w` inside the explorer list to run `pick_win`, then `jump`

Explorer list keymap:

```text
w -> pick window, then jump
```

### `tmux-navigator.lua`

Adds:

- `christoomey/vim-tmux-navigator`

This plugin coordinates pane movement between Neovim splits and tmux panes.

Normal keymaps:

```text
Ctrl-h / Backspace -> move left
Ctrl-j             -> move down
Ctrl-k             -> move up
Ctrl-l             -> move right
```

Inside normal Neovim windows, those commands first try to move between Neovim windows. When there is no Neovim window in that direction, the plugin asks tmux to move to the adjacent tmux pane.

There is also a targeted explorer override for left movement. Some LazyVim explorer buffers can intercept or redirect `Ctrl-h`, so explorer-like filetypes map `Ctrl-h` and `Backspace` directly to:

```sh
tmux select-pane -L
```

The override applies to filetypes matching:

- `neo-tree`
- `NvimTree`
- `snacks_*`
- `snacks_picker_list`
- `snacks_picker_input`

This is intentionally scoped to explorer buffers so normal editing buffers still use `vim-tmux-navigator`.

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

That last point is what lets `vim-tmux-navigator` decide whether to move inside Neovim or escape out to tmux.

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

Prefer one plugin or feature area per file. That keeps each plugin's behavior easy to find and remove.

## Applying Changes

Because Home Manager links `config/nvim` to `~/.config/nvim`, most Neovim Lua changes are available after restarting Neovim or reloading Lazy.

If the link itself changes, rebuild the Home Manager/nix-darwin configuration:

```sh
darwin-rebuild switch --flake .#macbook
```
