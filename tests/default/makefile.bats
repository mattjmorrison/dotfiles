#!/usr/bin/env bats

setup_file() {
  ROOT_DIR="$(cd "$BATS_TEST_DIRNAME/../.." && pwd)"
  export ROOT_DIR
}

@test "make selects correct rebuild tool for platform" {
  output="$(make -f "$ROOT_DIR/Makefile" help HOST=imac 2>&1)"
  if [[ "$(uname)" == "Darwin" ]]; then
    [[ "$output" =~ REBUILD=(darwin-rebuild|nix\ run\ nix-darwin) ]]
  else
    [[ "$output" == *"REBUILD=nixos-rebuild"* ]]
  fi
}
