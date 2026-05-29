#!/usr/bin/env bats

setup_file() {
  ROOT_DIR="$(cd "$BATS_TEST_DIRNAME/../.." && pwd)"
  export ROOT_DIR
}

@test "flake discovers all host directories" {
  host_dirs="$(find "$ROOT_DIR/hosts" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort | tr '\n' ' ' | sed 's/ $//')"
  darwin_hosts="$(nix eval --impure --expr "
    let flake = builtins.getFlake \"$ROOT_DIR\";
    in builtins.concatStringsSep \" \" (builtins.sort builtins.lessThan (builtins.attrNames flake.darwinConfigurations))
  " --raw)"

  [ "$host_dirs" = "$darwin_hosts" ]
}
