setup_file() {
  ROOT_DIR="$(cd "$BATS_TEST_DIRNAME/../.." && pwd)"
  export ROOT_DIR

  if [[ -z "$HOST" ]]; then
    echo "HOST is required. Usage: HOST=<hostname> bats nixos-ssh.bats" >&2
    exit 1
  fi
}

@test "ssh is enabled" {
  result=$(nix develop --command nix eval --impure --expr "
    let flake = builtins.getFlake \"path:$PWD\";
      config = flake.configurations.${HOST}.config;
    in config.services.openssh.enable
  ")
  [ "$result" = "true" ]
}

@test "password authentication is disabled" {
  result=$(nix develop --command nix eval --impure --expr "
    let flake = builtins.getFlake \"path:$PWD\";
      config = flake.configurations.${HOST}.config;
    in config.services.openssh.settings.PasswordAuthentication
  ")
  [ "$result" = "false" ]
}

@test "authorized keys are configured" {
  result=$(nix develop --command nix eval --impure --expr "
    let flake = builtins.getFlake \"path:$PWD\";
      config = flake.configurations.${HOST}.config;
    in builtins.length config.users.users.mattjmorrison.openssh.authorizedKeys.keys
  ")
  [ "$result" -gt 0 ]
}
