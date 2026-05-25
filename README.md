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
└── flake.nix
```

## Directories

- `config/` - raw application config linked or copied into place by Home Manager.
- `docs/` - detailed documentation for Nix wiring and configured tools.
- `hosts/` - machine-specific nix-darwin and Home Manager entry points.
- `modules/` - reusable nix-darwin and Home Manager modules.

## Makefile

The Makefile wraps the common Nix workflow targets:

- `make install-nix` - install Nix with the official multi-user installer.
- `make check` - check the flake.
- `make fmt` - format Nix files.
- `make lint-nix` - lint Nix files.
- `make build` - build the nix-darwin configuration.
- `sudo make switch` - apply the nix-darwin configuration.

## Documentation

- `docs/nix.md` - Nix, nix-darwin, Home Manager, module wiring, and common commands.
- `docs/neovim.md` - Neovim/LazyVim setup.
- `docs/tmux.md` - tmux setup.
- `docs/zsh.md` - zsh setup.
- `hosts/macbook/README.md` - MacBook host wiring.
- `modules/darwin/README.md` - nix-darwin module list.
- `modules/home/README.md` - Home Manager module list.
