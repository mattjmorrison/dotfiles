# Nix Configuration

This repo uses Nix flakes, nix-darwin, and Home Manager to manage a macOS machine.

## Overview

The configuration has three layers:

- `flake.nix` pins inputs and exposes host builds.
- `hosts/` contains one directory per machine, each with a `default.nix` and a `settings.nix` with user-specific values.
- `modules/` contains reusable nix-darwin, Home Manager, and shared MacBook configuration.

Tool-specific behavior lives in separate docs:

- `docs/firefox.md`
- `docs/neovim.md`
- `docs/tmux.md`
- `docs/zsh.md`

## Flake

The top-level flake is:

```text
flake.nix
```

It pins:

- `nixpkgs` from `github:NixOS/nixpkgs/nixos-unstable`
- `nix-darwin` from `github:nix-darwin/nix-darwin/master`
- `home-manager` from `github:nix-community/home-manager`

Both `nix-darwin` and `home-manager` follow the same `nixpkgs` input, so the system and user configuration use one package set.

The flake uses [flake-parts](https://github.com/hercules-ci/flake-parts) to split outputs into modules. The dev shell and formatter are defined in `dev/shell.nix` as a `perSystem` module. The `darwinConfigurations` output lives in the `flake` layer since it is not a per-system output.

The flake automatically discovers host directories under `hosts/` and exposes one `darwinConfigurations` entry per host. All configurations target:

```text
aarch64-darwin
```

The flake passes `inputs` through `specialArgs` so host and module files can access them. It also loads each host's `settings.nix` and passes it through `specialArgs` as `settings`, giving modules access to the host's user-specific values.

The flake also exposes:

- `devShells.aarch64-darwin.default` with formatter, linter, Neovim, Bats, and tmux tooling for local development workflows.
- `formatter.aarch64-darwin`, backed by `nixfmt-tree`.

## Host Wiring

Each host lives in its own directory under `hosts/`:

```text
hosts/matt-nix/
hosts/matthewmorrison/
hosts/mmorrison/
```

Every host directory contains two files:

- `default.nix` — imports the shared MacBook module (`modules/macbook`). This is identical across all hosts.
- `settings.nix` — a plain attrset with user-specific values: `username`, `homeDirectory`, `fullName`, `email`, and Firefox profile configuration.

The flake loads each host's `settings.nix` and passes it as `settings` through `specialArgs`, making it available to all modules in that configuration.

To add a new host, create a new directory under `hosts/` with a `default.nix` and `settings.nix`, then add a `darwinConfigurations` entry in `flake.nix`.

## MacBook Module

The shared MacBook configuration lives in:

```text
modules/macbook/
```

All MacBook hosts import this module. It contains:

- `default.nix` — enables nix-homebrew, imports `modules/darwin`, and wires Home Manager.
- `home-manager.nix` — configures the Home Manager integration for the host user.
- `home.nix` — Home Manager profile; imports `modules/home` and sets `home.username` and `home.stateVersion`.

## Darwin Modules

Darwin modules live in:

```text
modules/darwin/
```

`modules/darwin/default.nix` imports every Darwin module:

- `docker.nix`
- `homebrew.nix`
- `nix.nix`
- `system.nix`
- `users.nix`

### `docker.nix`

Installs Docker tooling through Homebrew:

- `colima`
- `docker`

Colima provides the local Linux VM/runtime on macOS. The Docker CLI talks to that runtime after Colima is started:

```sh
colima start
docker ps
```

### `homebrew.nix`

Enables Homebrew through nix-darwin and installs casks:

- Ghostty
- Karabiner-Elements
- Rectangle
- Firefox Developer Edition

### `nix.nix`

Disables nix-darwin's built-in Nix management:

```nix
nix.enable = false;
```

It also allows specific unfree packages:

- `claude-code`
- `github-copilot-cli`

The allowlist is intentionally narrow. Add package names here when a new managed Nix package requires unfree licensing.

### `system.nix`

Sets core system values:

```nix
system.stateVersion = 6;
system.primaryUser = settings.user.username;
programs.zsh.enable = true;
```

Detailed zsh behavior is documented in `docs/zsh.md`.

### `users.nix`

Defines the macOS home directory for the managed user:

```nix
users.users.${settings.user.username}.home = settings.user.homeDirectory;
```

## Home Manager Modules

Home Manager modules live in:

```text
modules/home/
```

`modules/home/default.nix` imports every Home Manager module:

- `ai.nix`
- `firefox.nix`
- `git.nix`
- `karabiner.nix`
- `neovim.nix`
- `nix-dev.nix`
- `shell.nix`

### `ai.nix`

Installs AI CLI tools:

- `claude-code`
- `codex`
- `github-copilot-cli`

These packages come from the pinned `nixpkgs` input in `flake.lock`. To pick up newer CLI releases, update `nixpkgs` and then switch the system. Fast-moving tools such as `codex` can still lag their upstream releases until nixpkgs updates its package definition.

### `firefox.nix`

Manages Firefox profiles while leaving the Firefox Developer Edition app installed through Homebrew.

Profile names and the default profile come from `settings.firefox`.

Detailed Firefox behavior is documented in `docs/firefox.md`.

### `git.nix`

Enables Git and configures:

- default branch: `main`
- user name from `settings.user.fullName`
- user email from `settings.user.email`
- automatic upstream setup on push
- editor: `nvim`

It also installs:

- `gh`
- `lazygit`

### `karabiner.nix`

Writes:

```text
~/.config/karabiner/karabiner.json
```

Current behavior:

- Caps Lock sends Control when held.
- Caps Lock sends Escape when tapped alone.
- the tap-alone timeout is 250 milliseconds.
- Karabiner's virtual keyboard type is pinned to ANSI, which prevents the keyboard type prompt after rebuilds.

### `neovim.nix`

Installs Neovim and supporting command-line tools, then links:

```text
config/nvim -> ~/.config/nvim
```

Detailed Neovim behavior is documented in `docs/neovim.md`.

### `nix-dev.nix`

Installs Nix development tooling:

- `deadnix`
- `lua-language-server`
- `nil`
- `nixfmt`
- `selene`
- `shellcheck`
- `shfmt`
- `statix`
- `stylua`

### `shell.nix`

Manages shell and terminal tooling:

- installs `tmux`
- links `config/tmux/tmux.conf` to `~/.tmux.conf`
- writes Ghostty config to `~/.config/ghostty/config.ghostty`
- sets Ghostty to treat the macOS Option key as Alt
- enables zsh through Home Manager
- enables zsh completion, autosuggestions, and syntax highlighting
- loads custom zsh aliases from `config/zsh/aliases.zsh`
- enables Starship with zsh integration

Detailed shell behavior is documented in:

- `docs/zsh.md` — covers zsh behavior in depth; intentionally overlaps with the summary above.
- `docs/tmux.md`

## Managed Files

This repo writes or links these user-facing files:

| Source | Destination | Managed By |
| --- | --- | --- |
| `config/nvim/` | `~/.config/nvim` | `modules/home/neovim.nix` |
| `config/zsh/aliases.zsh` | generated zsh init content | `modules/home/shell.nix` |
| `config/tmux/tmux.conf` | `~/.tmux.conf` | `modules/home/shell.nix` |
| inline Nix text | `~/.config/ghostty/config.ghostty` | `modules/home/shell.nix` |
| inline Nix JSON | `~/.config/karabiner/karabiner.json` | `modules/home/karabiner.nix` |
| inline Firefox profile metadata | `~/Library/Application Support/Firefox/profiles.ini` | `modules/home/firefox.nix` |

`config/nvim/` is linked recursively so Neovim can be edited as normal application config inside this repo.

## Package Sources

Packages come from two places:

- Nix packages through `nixpkgs`
- GUI casks through Homebrew

Use Nix packages for CLI tools and declarative user/system configuration.

Use Homebrew casks for macOS GUI applications that are easier or more practical to install as casks.

## Common Commands

Show available Makefile targets:

```sh
make help
```

Update the pinned `nixpkgs` flake input, which is how Nix-managed CLI packages such as `codex` move to newer nixpkgs versions:

```sh
make update-nixpkgs
```

After updating, apply the configuration with:

```sh
sudo make switch
```

Check the flake:

```sh
make check
```

Format Nix, Lua, and Bats files:

```sh
make fmt
```

Lint Nix, Lua, and Bats files:

```sh
make lint
```

Lint Nix files:

```sh
make lint-nix
```

Run the full preflight used before build and switch. This runs Nix, Lua, and Bats linting, flake checks, Neovim tests, and tmux/Neovim integration tests:

```sh
make preflight
```

Launch Neovim with this repo's config without switching the system:

```sh
make nvim-dev
```

Run the Neovim-only movement tests:

```sh
make test-nvim
```

Run the tmux-backed Neovim navigation integration tests:

```sh
make test-tmux-nvim
```

Build the macOS system configuration:

```sh
make build
```

Apply the macOS system configuration:

```sh
sudo make switch
```

Install Nix with the official multi-user installer:

```sh
make install-nix
```

`HOST` is required for targets that build or apply the configuration. Pass it explicitly:

```sh
make build HOST=matt-nix
sudo make switch HOST=matt-nix
```

## Adding Something New

For a new host:

1. Add a directory under `hosts/`.
2. Add a `default.nix` that imports `../../modules/macbook`.
3. Add a `settings.nix` with the host's user values (`username`, `homeDirectory`, `fullName`, `email`, and Firefox profile config).

The flake discovers host directories automatically — no changes to `flake.nix` are needed.

For a new reusable Darwin setting:

1. Add or edit a file under `modules/darwin/`.
2. Import new module files from `modules/darwin/default.nix`.

For a new user-level package or dotfile:

1. Add or edit a file under `modules/home/`.
2. Import new module files from `modules/home/default.nix`.

For app config that should stay editable as normal files:

1. Put the app config under `config/`.
2. Link it from the appropriate Home Manager module.
3. Add detailed behavior docs under `docs/` if the config has non-obvious customizations.
