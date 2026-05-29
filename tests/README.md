# Tests

Integration tests written in [Bats](https://github.com/bats-core/bats-core). All suites run inside the Nix dev shell.

## Suites

### `darwin-homebrew.bats`

Validates the Nix-declared Homebrew configuration by evaluating the flake directly. Does not require a switched system — runs against the Nix config in the repo.

Run with:

```sh
make test-homebrew HOST=<username>
```

### `homebrew-acceptance.bats`

Validates that Homebrew packages are actually installed and available on the current machine. Requires the configuration to have been switched onto the host.

Run with:

```sh
make test-homebrew-acceptance
```

### `tmux-nvim-navigation.bats`

Validates tmux/Neovim split navigation keybindings end-to-end by spawning a real tmux session with Neovim and sending keystrokes. Uses the repo's `config/nvim` directly via isolated XDG dirs — does not require a switched system.

Run with:

```sh
make test-tmux-nvim
```

### `home-manager.bats`

Validates the Home Manager integration settings by evaluating the flake directly. Checks that `useGlobalPkgs`, `useUserPackages`, and `backupFileExtension` are correctly set, and that the host user is wired up in the Home Manager user map. Does not require a switched system.

Run with:

```sh
make test-home-manager HOST=<username>
```

### `host-discovery.bats`

Validates that the flake's `darwinConfigurations` output matches the directories present under `hosts/`. Catches any mismatch between the filesystem and what the flake exposes. Does not require `HOST`.

Run with:

```sh
make test-host-discovery
```

## Running All Tests

```sh
make test HOST=<username>
```
