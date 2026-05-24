# Dotfiles

macOS dotfiles managed with Nix flakes, nix-darwin, and Home Manager.

## Layout

```text
.
├── flake.nix
├── flake.lock
├── hosts/
├── modules/
└── config/
```

### `flake.nix`

Top-level flake entry point. It pins the main inputs:

- `nixpkgs`
- `nix-darwin`
- `home-manager`

It currently exposes one Darwin host configuration:

- `darwinConfigurations.macbook`

The flake intentionally stays small. Host-specific wiring lives under `hosts/`, while reusable configuration lives under `modules/`.

### `hosts/`

Concrete machine definitions. A host decides which reusable modules are enabled and how they are connected.

Current hosts:

- `hosts/macbook/` - macOS configuration for the `macbook` nix-darwin target.

Important files:

- `hosts/macbook/default.nix` - imports nix-darwin modules, Home Manager, and host-specific Home Manager wiring.
- `hosts/macbook/home-manager.nix` - enables Home Manager integration for the `matt-nix` user.
- `hosts/macbook/home.nix` - Home Manager profile for the `matt-nix` user on this host.

### `modules/darwin/`

Reusable nix-darwin system modules. These configure macOS-level behavior and machine-level packages/apps.

Current modules:

- `default.nix` - imports all Darwin modules.
- `homebrew.nix` - enables Homebrew and installs casks.
- `nix.nix` - configures Nix/nixpkgs behavior, including the unfree package allowlist.
- `system.nix` - sets nix-darwin system state, primary user, and zsh support.
- `users.nix` - defines the macOS home directory for `matt-nix`.

### `modules/home/`

Reusable Home Manager modules. These configure user-level packages, shell behavior, tools, and dotfiles.

Current modules:

- `default.nix` - imports all Home Manager modules.
- `ai.nix` - installs AI CLI tools.
- `git.nix` - configures Git and installs Lazygit.
- `karabiner.nix` - writes the Karabiner configuration.
- `neovim.nix` - installs Neovim and supporting tools, then links `config/nvim` into `~/.config/nvim`.
- `shell.nix` - configures zsh, Starship, and shell packages.

### `config/`

Raw application configuration that is linked or copied into place by Nix/Home Manager modules.

Current configs:

- `config/nvim/` - Neovim/LazyVim configuration.

Keeping raw app configuration here keeps it separate from the Nix modules that install and link it.

## What Gets Installed And Configured

### macOS System

The nix-darwin configuration:

- sets `system.stateVersion = 6`
- sets `system.primaryUser = "matt-nix"`
- enables zsh at the system level
- defines `/Users/matt-nix` as the home directory for the `matt-nix` user
- disables nix-darwin's Nix management with `nix.enable = false`

### Homebrew Casks

Homebrew is enabled through nix-darwin and installs:

- Ghostty
- Karabiner-Elements
- Rectangle
- Firefox Developer Edition

### Home Manager

Home Manager is integrated through nix-darwin with:

- global nixpkgs shared with nix-darwin
- user packages enabled
- file conflict backups using the `.backup` extension
- user profile for `matt-nix`

### Shell

The shell module configures:

- zsh
- zsh completion
- zsh autosuggestions
- zsh syntax highlighting
- Starship prompt with zsh integration
- tmux config from `config/tmux/tmux.conf`

It also installs:

- tmux

### Git

Git is configured with:

- default branch: `main`
- user name: `Matt Morrison`
- user email: `mattjmorrison@mattjmorrison.com`
- automatic upstream setup on push
- editor: `nvim`

It also installs:

- lazygit

### Neovim

The Neovim module installs:

- neovim
- ripgrep
- fd
- tree-sitter
- nodejs
- gcc
- unzip
- wget

It links:

- `config/nvim` to `~/.config/nvim`

The Neovim config is based on LazyVim and lives outside the Nix module tree so it can be edited like a normal application config.

### Karabiner

Karabiner is configured through Home Manager by writing:

- `~/.config/karabiner/karabiner.json`

Current keyboard behavior:

- Caps Lock sends Control when held.
- Caps Lock sends Escape when tapped alone.

### AI CLI Tools

The AI module installs:

- Claude Code
- Codex
- GitHub Copilot CLI

The required unfree packages are allowlisted in `modules/darwin/nix.nix`.

## Common Commands

Check the flake:

```sh
nix flake check
```

Build the macOS system configuration:

```sh
darwin-rebuild build --flake .#macbook
```

Apply the macOS system configuration:

```sh
darwin-rebuild switch --flake .#macbook
```
