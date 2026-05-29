HOST ?= $(error HOST is required. Usage: make <target> HOST=<username>)
FLAKE ?= .\#$(HOST)
DARWIN_REBUILD ?= $(shell command -v darwin-rebuild 2>/dev/null || echo "nix run nix-darwin --")
NIX_DEVELOP ?= nix develop --command
NVIM_ARGS ?=
NVIM_DEV_ENV = XDG_CONFIG_HOME="$(CURDIR)/config" XDG_STATE_HOME="$(CURDIR)/.nvim-dev/state" XDG_CACHE_HOME="$(CURDIR)/.nvim-dev/cache"

.PHONY: help bootstrap install-nix update-nixpkgs check fmt fmt-nix fmt-lua fmt-bats lint lint-nix lint-lua lint-lua-diagnostics lint-bats preflight nvim-dev test test-nvim test-tmux-nvim test-homebrew test-home-manager test-host-discovery test-homebrew-acceptance build switch validate-root

help:
	@echo "Targets:"
	@echo "  bootstrap    Install Nix (first-time setup)"
	@echo "  install-nix  Install Nix with the official multi-user installer"
	@echo "  update-nixpkgs Update the pinned nixpkgs flake input"
	@echo "  check        Check the flake"
	@echo "  fmt          Format Nix, Lua, and Bats files"
	@echo "  lint         Lint Nix, Lua, and Bats files"
	@echo "  lint-nix     Lint Nix files"
	@echo "  lint-lua     Lint Lua files"
	@echo "  lint-lua-diagnostics Check LuaLS diagnostics through Neovim"
	@echo "  lint-bats    Lint Bats files"
	@echo "  preflight    Run Nix linting, flake checks, and tests"
	@echo "  nvim-dev     Launch Neovim with this repo's config/nvim without switching"
	@echo "  test         Run all tests"
	@echo "  test-nvim    Run Neovim movement tests"
	@echo "  test-tmux-nvim Run tmux/Neovim integration tests"
	@echo "  test-homebrew Run Darwin/Homebrew declaration tests"
	@echo "  test-home-manager Run Home Manager declaration tests"
	@echo "  test-host-discovery Run host discovery tests"
	@echo "  test-homebrew-acceptance Run host Homebrew acceptance tests"
	@echo "  build        Build the nix-darwin configuration"
	@echo "  switch       Apply the nix-darwin configuration; requires sudo"
	@echo ""
	@echo "Variables:"
	@echo "  HOST=$(HOST)"
	@echo "  FLAKE=$(FLAKE)"
	@echo "  DARWIN_REBUILD=$(DARWIN_REBUILD)"
	@echo "  NIX_DEVELOP=$(NIX_DEVELOP)"

bootstrap:
	curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install | sh -s -- --daemon
	@echo ""
	@echo "Nix installed. Open a new shell, then run: sudo make switch HOST=<username>"

install-nix:
	curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install | sh -s -- --daemon

update-nixpkgs:
	nix flake update nixpkgs

check:
	nix flake check

fmt: fmt-nix fmt-lua fmt-bats

fmt-nix:
	nix fmt

fmt-lua:
	$(NIX_DEVELOP) stylua --config-path config/nvim/stylua.toml config/nvim

fmt-bats:
	$(NIX_DEVELOP) shfmt -w -i 2 -ln bats tests/integration/*.bats

lint: lint-nix lint-lua lint-bats
test: test-nvim test-tmux-nvim test-homebrew test-home-manager test-host-discovery

lint-nix:
	$(NIX_DEVELOP) statix check .
	$(NIX_DEVELOP) deadnix --fail .
	nix fmt -- --ci

lint-lua:
	$(NIX_DEVELOP) stylua --check --config-path config/nvim/stylua.toml config/nvim
	$(NIX_DEVELOP) selene config/nvim
	$(MAKE) lint-lua-diagnostics

lint-lua-diagnostics:
	@had_copilot_config=0; \
	if [ -e "$(CURDIR)/config/github-copilot" ]; then had_copilot_config=1; fi; \
	$(NIX_DEVELOP) env $(NVIM_DEV_ENV) nvim --headless -S config/nvim/tests/lua_diagnostics.lua; \
	status=$$?; \
	if [ "$$had_copilot_config" -eq 0 ]; then rm -rf "$(CURDIR)/config/github-copilot"; fi; \
	exit $$status

lint-bats:
	$(NIX_DEVELOP) shfmt -d -i 2 -ln bats tests/integration/*.bats
	$(NIX_DEVELOP) shellcheck tests/integration/*.bats

preflight: lint check test

nvim-dev:
	$(NVIM_DEV_ENV) nvim $(NVIM_ARGS)

test-nvim:
	@$(NIX_DEVELOP) env $(NVIM_DEV_ENV) nvim --headless -u config/nvim/tests/minitest.lua

test-tmux-nvim:
	@nix develop --command bats tests/integration/tmux-nvim-navigation.bats

test-homebrew:
	@HOST=$(HOST) nix develop --command bats tests/integration/darwin-homebrew.bats

test-home-manager:
	@HOST=$(HOST) nix develop --command bats tests/integration/home-manager.bats

test-host-discovery:
	@nix develop --command bats tests/integration/host-discovery.bats

test-homebrew-acceptance:
	@nix develop --command bats tests/integration/homebrew-acceptance.bats

build: preflight
	$(DARWIN_REBUILD) build --flake $(FLAKE)

switch: validate-root
	@if [ -n "$$SUDO_USER" ] && [ "$$SUDO_USER" != "root" ]; then \
		sudo -u "$$SUDO_USER" -H $(MAKE) preflight; \
	else \
		$(MAKE) preflight; \
	fi
	HOME=/var/root $(DARWIN_REBUILD) switch --flake $(FLAKE)
	@if [ -n "$$SUDO_USER" ] && [ "$$SUDO_USER" != "root" ]; then \
		sudo -u "$$SUDO_USER" -H $(MAKE) test-homebrew-acceptance; \
	else \
		$(MAKE) test-homebrew-acceptance; \
	fi

validate-root:
	@if [ "$$(id -u)" -ne 0 ]; then \
		echo "error: switch must be run as root. Use: sudo make switch"; \
		exit 1; \
	fi
