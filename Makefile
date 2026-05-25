HOST ?= macbook
FLAKE ?= .\#$(HOST)

.PHONY: help install-nix check fmt lint-nix build switch validate-root

help:
	@echo "Targets:"
	@echo "  install-nix  Install Nix with the official multi-user installer"
	@echo "  check        Check the flake"
	@echo "  fmt          Format Nix files"
	@echo "  lint-nix     Lint Nix files"
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

build:
	darwin-rebuild build --flake $(FLAKE)

switch: validate-root
	darwin-rebuild switch --flake $(FLAKE)

validate-root:
	@if [ "$$(id -u)" -ne 0 ]; then \
		echo "error: switch must be run as root. Use: sudo make switch"; \
		exit 1; \
	fi
