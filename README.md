# Dotfiles

macOS dotfiles managed with Nix flakes, nix-darwin, and Home Manager.

## Getting Started

1. Install Xcode Command Line Tools (required for `make`):

   ```sh
   xcode-select --install
   ```

2. Download this repo as a zip from GitHub and extract it.

3. Install Nix:

   ```sh
   make bootstrap
   ```

4. Open a new shell, then apply the configuration:

   ```sh
   sudo make switch HOST=<username>
   ```

   Where `<username>` is your macOS username — see the `hosts/` directory for available hosts. On the first run this bootstraps nix-darwin, installs Homebrew, and applies the full configuration. Subsequent runs use `darwin-rebuild` directly.

## Layout

```text
.
├── config/
├── dev/
├── docs/
├── hosts/
│   ├── matt-nix/
│   ├── matthewmorrison/
│   └── mmorrison/
├── modules/
│   ├── darwin/
│   ├── home/
│   └── macbook/
├── tests/
├── Makefile
├── flake.lock
├── flake.nix
├── neovim.yml
├── selene.toml
└── .markdownlint-cli2.yaml
```

## Directories

- `config/` - raw application config linked or copied into place by Home Manager.
- `dev/` - flake-parts module defining the dev shell and formatter.
- `docs/` - detailed documentation for Nix wiring and configured tools.
- `hosts/` - one directory per machine. Each contains a minimal `default.nix` and a `settings.nix` with user-specific values.
- `modules/darwin/` - reusable nix-darwin system modules.
- `modules/home/` - reusable Home Manager user modules.
- `modules/macbook/` - shared MacBook profile imported by all MacBook hosts.

## Linting

Three root-level files configure the linters used by `make lint`:

- `selene.toml` - Selene (Lua linter) config. Sets the standard to `neovim` and allows mixed tables.
- `neovim.yml` - Selene library definition for the Neovim Lua environment. Declares `vim` and other Neovim globals so Selene does not flag them as undefined.
- `.markdownlint-cli2.yaml` - markdownlint config. Currently relaxes the line-length rule (MD013) to 200 characters.

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
- `modules/macbook/README.md` - shared MacBook profile.
- `modules/darwin/README.md` - nix-darwin module list.
- `modules/home/README.md` - Home Manager module list.
