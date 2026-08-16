setup_file() {
  ROOT_DIR="$(cd "$BATS_TEST_DIRNAME/../.." && pwd)"
  export ROOT_DIR

  if [[ -z "$HOST" ]]; then
    echo "HOST is required. Usage: HOST=<hostname> bats imac-docker.bats" >&2
    exit 1
  fi
}

@test "virtualisation.docker is enabled" {
  result=$(nix develop --command nix eval --impure --expr "
    let flake = builtins.getFlake \"path:$PWD\";
      config = flake.configurations.${HOST}.config;
    in config.virtualisation.docker.enable
  ")
  [ "$result" = "true" ]
}

@test "user is in the docker extraGroups" {
  result=$(nix develop --command nix eval --impure --expr "
    let flake = builtins.getFlake \"path:$PWD\";
      config = flake.configurations.${HOST}.config;
      settings = import $PWD/hosts/${HOST}/settings.nix;
    in builtins.elem \"docker\" config.users.users.\${settings.user.username}.extraGroups
  ")
  [ "$result" = "true" ]
}
