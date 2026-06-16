HOST ?= $(error HOST is required. Usage: make <target> HOST=<username>)
FLAKE ?= .\#$(HOST)
DARWIN_REBUILD ?= $(shell command -v darwin-rebuild 2>/dev/null || echo "nix run nix-darwin --")
NIX_DEVELOP ?= nix develop --command

# nix.enable = false in modules/darwin/nix.nix, so flakes are not enabled system-wide.
export NIX_CONFIG = experimental-features = nix-command flakes
NVIM_ARGS ?=
NVIM_DEV_ENV = XDG_CONFIG_HOME="$(CURDIR)/config" XDG_STATE_HOME="$(CURDIR)/.nvim-dev/state" XDG_CACHE_HOME="$(CURDIR)/.nvim-dev/cache"

.PHONY: help install install-nix bootstrap update-nixpkgs check fmt fmt-nix fmt-lua fmt-bats lint lint-nix lint-lua lint-lua-diagnostics lint-bats preflight nvim-dev test test-nvim test-tmux-nvim test-homebrew test-home-manager test-host-discovery test-lazygit-config test-homebrew-acceptance build switch validate-root

help:
	@echo "Targets:"
	@echo "  install      First-time setup: install Nix and bootstrap nix-darwin"
	@echo "  install-nix  Install Nix with the official multi-user installer"
	@echo "  bootstrap    First-time nix-darwin activation; installs darwin-rebuild. Requires sudo"
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
	@echo "  test-lazygit-config Run lazygit keybinding config validation tests"
	@echo "  test-homebrew-acceptance Run host Homebrew acceptance tests"
	@echo "  build        Build the nix-darwin configuration"
	@echo "  switch       Apply the nix-darwin configuration; requires sudo"
	@echo ""
	@echo "Variables:" 
	@echo "  HOST=$(HOST)"
	@echo "  FLAKE=$(FLAKE)"
	@echo "  DARWIN_REBUILD=$(DARWIN_REBUILD)"
	@echo "  NIX_DEVELOP=$(NIX_DEVELOP)"

install:
	@if [ "$$(id -u)" -eq 0 ]; then \
		echo "error: run 'make install' as your normal user (not with sudo)."; \
		exit 1; \
	fi
	@if [ ! -x /nix/var/nix/profiles/default/bin/nix ]; then \
		$(MAKE) install-nix; \
	fi
	@if command -v darwin-rebuild >/dev/null 2>&1; then \
		echo "Already set up. Use 'sudo make switch' to apply updates."; \
		exit 0; \
	fi
	sudo $(MAKE) bootstrap
	@echo ""
	@echo "Done. Open a new shell so 'nix' and 'darwin-rebuild' are on PATH."

install-nix:
	curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install | sh -s -- --daemon

update-nixpkgs:
	nix flake update nixpkgs

bootstrap: validate-root
	@if command -v darwin-rebuild >/dev/null 2>&1; then \
		echo "darwin-rebuild is already installed; use 'sudo make switch' instead."; \
		exit 0; \
	fi
	@for f in /etc/zshrc /etc/bashrc; do \
		if [ -f "$$f" ] && [ ! -e "$$f.before-nix-darwin" ]; then \
			echo "Moving $$f -> $$f.before-nix-darwin so nix-darwin can manage it"; \
			mv "$$f" "$$f.before-nix-darwin"; \
		fi; \
	done
	@user_home=$$(eval echo "~$$SUDO_USER"); \
	for p in .tmux.conf .zshrc; do \
		f="$$user_home/$$p"; \
		if { [ -e "$$f" ] || [ -L "$$f" ]; } && [ ! -e "$$f.before-home-manager" ]; then \
			echo "Moving $$f -> $$f.before-home-manager so home-manager can manage it"; \
			mv "$$f" "$$f.before-home-manager"; \
		fi; \
	done
	@if [ -n "$$SUDO_USER" ] && [ "$$SUDO_USER" != "root" ]; then \
		sudo -u "$$SUDO_USER" -H env "PATH=/nix/var/nix/profiles/default/bin:$$PATH" $(MAKE) preflight; \
	else \
		env "PATH=/nix/var/nix/profiles/default/bin:$$PATH" $(MAKE) preflight; \
	fi
	HOME=/var/root PATH="/nix/var/nix/profiles/default/bin:$$PATH" nix run github:nix-darwin/nix-darwin/master#darwin-rebuild -- switch --flake $(FLAKE)

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
test: test-nvim test-tmux-nvim test-homebrew test-home-manager test-host-discovery test-lazygit-config

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

test-lazygit-config:
	@HOST=$(HOST) nix develop --command bats tests/integration/lazygit-config.bats

test-homebrew-acceptance:
	@nix develop --command bats tests/integration/homebrew-acceptance.bats

build: preflight
	$(DARWIN_REBUILD) build --flake $(FLAKE)

switch: validate-root
	@if [ -n "$$SUDO_USER" ] && [ "$$SUDO_USER" != "root" ]; then \
		sudo -u "$$SUDO_USER" -H $(MAKE) preflight HOST=$(HOST); \
	else \
		$(MAKE) preflight HOST=$(HOST); \
	fi
	HOME=/var/root $(DARWIN_REBUILD) switch --flake $(FLAKE)
	@if [ -n "$$SUDO_USER" ] && [ "$$SUDO_USER" != "root" ]; then \
		sudo -u "$$SUDO_USER" -H $(MAKE) test-homebrew-acceptance HOST=$(HOST); \
	else \
		$(MAKE) test-homebrew-acceptance HOST=$(HOST); \
	fi

validate-root:
	@if [ "$$(id -u)" -ne 0 ]; then \
		echo "error: switch must be run as root. Use: sudo make switch"; \
		exit 1; \
	fi
