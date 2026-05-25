# Tmux Configuration

This repo manages tmux through Home Manager.

## Where It Lives

```text
config/tmux/tmux.conf
```

Home Manager links that file into place as:

```text
~/.tmux.conf
```

The link is defined in:

```text
modules/home/shell.nix
```

That module also installs:

- `tmux`

## Prefix

The default tmux prefix is disabled:

```tmux
unbind-key C-b
```

The configured prefix is:

```text
Ctrl-Space
```

Pressing `Ctrl-Space` twice sends the prefix through to the active pane:

```tmux
bind-key C-Space send-prefix
```

## Splits

Two prefix bindings create new panes:

| Key | Behavior |
| --- | --- |
| `Ctrl-Space` then `\` | Split the current pane horizontally, creating a side-by-side pane |
| `Ctrl-Space` then `-` | Split the current pane vertically, creating a pane above or below |

These map directly to:

```tmux
bind-key \\ split-window -h
bind-key - split-window -v
```

## Pane Motion

The config binds pane motion keys globally, without requiring the tmux prefix:

| Key | Direction |
| --- | --- |
| `Ctrl-h` | Left |
| `Ctrl-j` | Down |
| `Ctrl-k` | Up |
| `Ctrl-l` | Right |

Each binding checks the command running in the current tmux pane.

If the active pane is running Vim, Neovim, or a related diff/view command, tmux sends the key through to the editor:

```text
send-keys C-h
send-keys C-j
send-keys C-k
send-keys C-l
```

If the active pane is not running Vim or Neovim, tmux handles the movement itself:

```text
select-pane -L
select-pane -D
select-pane -U
select-pane -R
```

The command detection pattern is:

```text
^(n?vim|view|l?nvim?)(diff)?$
```

That matches common Vim and Neovim command names, including diff variants.

## Neovim Integration

Neovim configures `christoomey/vim-tmux-navigator` in:

```text
config/nvim/lua/plugins/tmux-navigator.lua
```

That plugin defines matching Neovim keymaps:

| Key | Neovim Command |
| --- | --- |
| `Ctrl-h` | `:TmuxNavigateLeft` |
| `Backspace` | `:TmuxNavigateLeft` |
| `Ctrl-j` | `:TmuxNavigateDown` |
| `Ctrl-k` | `:TmuxNavigateUp` |
| `Ctrl-l` | `:TmuxNavigateRight` |

Together, the tmux and Neovim configs create one movement model:

1. Press `Ctrl-h/j/k/l`.
2. tmux checks whether the active pane is running Vim or Neovim.
3. If not, tmux switches directly to the adjacent tmux pane.
4. If yes, tmux sends the key into Neovim.
5. Neovim first tries to move between Neovim windows.
6. If there is no Neovim window in that direction, `vim-tmux-navigator` asks tmux to move to the adjacent tmux pane.

The result is that `Ctrl-h/j/k/l` works across both Neovim splits and tmux panes without needing to think about which layer currently owns focus.

## Explorer Overrides

Some LazyVim explorer buffers can intercept or redirect left movement. To keep pane movement consistent, the Neovim config adds a buffer-local override for explorer-like filetypes.

For these filetypes:

- `neo-tree`
- `NvimTree`
- `snacks_*`
- `snacks_picker_list`
- `snacks_picker_input`

Neovim maps both keys directly to `tmux select-pane -L`:

```text
Ctrl-h
Backspace
```

That override only affects explorer buffers. Normal editing buffers continue to use `vim-tmux-navigator`.

## Copy Mode And Status Keys

Tmux uses vi-style keys for copy mode and status prompts:

```tmux
set-window-option -g mode-keys vi
set-option -g status-keys vi
```

## Status Bar

The status bar uses colors from the TokyoNight palette to match Neovim's `tokyonight-night` theme:

| Area | Foreground | Background |
| --- | --- | --- |
| status bar | `#c0caf5` | `#1a1b26` |
| active window | `#1a1b26` | `#7dcfff` |
| inactive windows | `#c0caf5` | `#1a1b26` |
| left status | `#1a1b26` | `#7dcfff` |
| right status | `#7dcfff` | `#1a1b26` |
| command/message prompt | `#1a1b26` | `#7dcfff` |

`#7dcfff` is the teal/cyan accent used to align tmux's active status elements with the Neovim statusline theme.

The left status shows the active session name:

```tmux
set-option -g status-left " #S "
```

The right status shows live tmux state and the current pane command:

```tmux
set-option -g status-right "#{?client_prefix, prefix ,}#{?window_zoomed_flag, zoom ,}#{?pane_synchronized, sync ,}#{pane_current_command} "
```

## Mouse

Mouse support is enabled globally:

```tmux
set-option -g mouse on
```

This allows selecting panes, resizing panes, scrolling, and interacting with tmux UI elements with the mouse.
