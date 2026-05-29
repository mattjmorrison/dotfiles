#!/usr/bin/env bats

setup_file() {
  ROOT_DIR="$(cd "$BATS_TEST_DIRNAME/../.." && pwd)"
  export ROOT_DIR
}

config_expr() {
  local expr="$1"

  nix eval --impure --expr "
    let
      flake = builtins.getFlake \"$ROOT_DIR\";
      config = flake.darwinConfigurations.macbook.config;
    in
      ${expr}
  " --raw
}

assert_true() {
  local actual="$1"
  local message="$2"

  if [[ "$actual" != "true" ]]; then
    fail "$message (got: $actual)"
  fi
}

@test "homebrew is enabled in the darwin config" {
  actual="$(config_expr 'if config.homebrew.enable then "true" else "false"')"
  assert_true "$actual" "expected homebrew.enable to be true"
}

@test "nix-homebrew installs homebrew itself" {
  actual="$(config_expr 'if config.nix-homebrew.enable && config.nix-homebrew.user == "matt-nix" && config.nix-homebrew.autoMigrate then "true" else "false"')"
  assert_true "$actual" "expected nix-homebrew to install and migrate homebrew"
}

@test "homebrew installs colima and docker" {
  actual="$(config_expr 'if builtins.any (brew: brew.name == "colima") config.homebrew.brews && builtins.any (brew: brew.name == "docker") config.homebrew.brews then "true" else "false"')"
  assert_true "$actual" "expected homebrew.brews to include colima and docker"
}

@test "homebrew installs firefox developer edition" {
  actual="$(config_expr 'if builtins.any (cask: cask.name == "firefox@developer-edition") config.homebrew.casks then "true" else "false"')"
  assert_true "$actual" "expected homebrew.casks to include firefox@developer-edition"
}
