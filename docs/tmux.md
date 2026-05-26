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
bind-key \\ split-window -h -c "#{pane_current_path}"
bind-key - split-window -v -c "#{pane_current_path}"
```

New split panes start in the current pane's working directory.

## Pane Motion

The config binds pane motion keys globally, without requiring the tmux prefix:

| Key | Direction |
| --- | --- |
| `Ctrl-h` | Left |
| `Ctrl-j` | Down |
| `Ctrl-k` | Up |
| `Ctrl-l` | Right |

Each binding checks the `@pane-is-vim` tmux variable set by `smart-splits.nvim`.

If the active pane is running Neovim with smart-splits loaded, tmux sends the key through to the editor:

```text
send-keys C-h
send-keys C-j
send-keys C-k
send-keys C-l
```

If the active pane is not marked as Neovim by smart-splits, tmux handles the movement itself:

```text
select-pane -L
select-pane -D
select-pane -U
select-pane -R
```

The config also binds pane resizing globally, using 3-cell steps:

| Key | Direction |
| --- | --- |
| `Option-h` | Left |
| `Option-j` | Down |
| `Option-k` | Up |
| `Option-l` | Right |

## Neovim Integration

Neovim configures `mrjones2014/smart-splits.nvim` in:

```text
config/nvim/lua/plugins/smart-splits.lua
```

That plugin defines matching Neovim keymaps:

| Key | Neovim Function |
| --- | --- |
| `Ctrl-h` | `move_cursor_left()` |
| `Backspace` | `move_cursor_left()` |
| `Ctrl-j` | `move_cursor_down()` |
| `Ctrl-k` | `move_cursor_up()` |
| `Ctrl-l` | `move_cursor_right()` |
| `Option-h` | `resize_left()` |
| `Option-j` | `resize_down()` |
| `Option-k` | `resize_up()` |
| `Option-l` | `resize_right()` |

Together, the tmux and Neovim configs create one movement model:

1. Press `Ctrl-h/j/k/l` or `Option-h/j/k/l`.
2. tmux checks whether smart-splits marked the active pane as Neovim.
3. If not, tmux switches directly to the adjacent tmux pane.
4. If yes, tmux sends the key into Neovim.
5. Neovim first tries to move or resize Neovim windows.
6. If there is no Neovim window in that direction, smart-splits asks tmux to act on the adjacent tmux pane.

The result is that movement and resizing work across both Neovim splits and tmux panes without needing to think about which layer currently owns focus.

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
