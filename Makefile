HOST ?= macbook
FLAKE ?= .\#$(HOST)
NVIM_ARGS ?=
NVIM_DEV_ENV = XDG_CONFIG_HOME="$(CURDIR)/config" XDG_STATE_HOME="$(CURDIR)/.nvim-dev/state" XDG_CACHE_HOME="$(CURDIR)/.nvim-dev/cache"

.PHONY: help install-nix check fmt lint-nix nvim-dev test-nvim build switch validate-root

help:
	@echo "Targets:"
	@echo "  install-nix  Install Nix with the official multi-user installer"
	@echo "  check        Check the flake"
	@echo "  fmt          Format Nix files"
	@echo "  lint-nix     Lint Nix files"
	@echo "  nvim-dev     Launch Neovim with this repo's config/nvim without switching"
	@echo "  test-nvim    Run Neovim movement tests"
	@echo "  build        Build the nix-darwin configuration"
	@echo "  switch       Apply the nix-darwin configuration; requires sudo"
	@echo ""
	@echo "Variables:"
	@echo "  HOST=$(HOST)"
	@echo "  FLAKE=$(FLAKE)"

install-nix:
	curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install | sh -s -- --daemon

check:
	nix flake check

fmt:
	nix fmt

lint-nix:
	statix check .
	deadnix --fail .
	nix fmt -- --ci

nvim-dev:
	$(NVIM_DEV_ENV) nvim $(NVIM_ARGS)

test-nvim:
	@$(NVIM_DEV_ENV) nvim --headless -u config/nvim/tests/minitest.lua

build:
	darwin-rebuild build --flake $(FLAKE)

switch: validate-root
	darwin-rebuild switch --flake $(FLAKE)

validate-root:
	@if [ "$$(id -u)" -ne 0 ]; then \
		echo "error: switch must be run as root. Use: sudo make switch"; \
		exit 1; \
	fi
