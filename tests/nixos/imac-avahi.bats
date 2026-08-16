setup_file() {
  ROOT_DIR="$(cd "$BATS_TEST_DIRNAME/../.." && pwd)"
  export ROOT_DIR

  if [[ -z "$HOST" ]]; then
    echo "HOST is required. Usage: HOST=<hostname> bats imac-avahi.bats" >&2
    exit 1
  fi
}

@test "avahi nssmdns4 is enabled" {
  result=$(nix develop --command nix eval --impure --expr "
    let flake = builtins.getFlake \"path:$PWD\";
      config = flake.configurations.${HOST}.config;
    in config.services.avahi.nssmdns4
  ")
  [ "$result" = "true" ]
}
