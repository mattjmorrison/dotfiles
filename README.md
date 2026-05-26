# Dotfiles

macOS dotfiles managed with Nix flakes, nix-darwin, and Home Manager.

## Layout

```text
.
├── config/
├── docs/
├── hosts/
├── modules/
├── Makefile
├── flake.lock
├── flake.nix
└── settings.nix
```

## Directories

- `config/` - raw application config linked or copied into place by Home Manager.
- `docs/` - detailed documentation for Nix wiring and configured tools.
- `hosts/` - machine-specific nix-darwin and Home Manager entry points.
- `modules/` - reusable nix-darwin and Home Manager modules.
- `settings.nix` - local user and profile values shared by modules.

## Makefile

The Makefile wraps the common Nix workflow targets:

- `make install-nix` - install Nix with the official multi-user installer.
- `make check` - check the flake.
- `make fmt` - format Nix, Lua, and Bats files.
- `make lint` - lint Nix, Lua, and Bats files.
- `make lint-nix` - lint Nix files.
- `make preflight` - run Nix linting, flake checks, and tests.
- `make nvim-dev` - launch Neovim with this repo's `config/nvim` without switching.
- `make test-nvim` - run Neovim movement tests.
- `make test-tmux-nvim` - run tmux/Neovim integration tests.
- `make build` - build the nix-darwin configuration.
- `sudo make switch` - apply the nix-darwin configuration.

## Documentation

- `docs/nix.md` - Nix, nix-darwin, Home Manager, module wiring, and common commands.
- `docs/firefox.md` - Firefox profile setup.
- `docs/neovim.md` - Neovim/LazyVim setup.
- `docs/tmux.md` - tmux setup.
- `docs/zsh.md` - zsh setup.
- `hosts/macbook/README.md` - MacBook host wiring.
- `modules/darwin/README.md` - nix-darwin module list.
- `modules/home/README.md` - Home Manager module list.
