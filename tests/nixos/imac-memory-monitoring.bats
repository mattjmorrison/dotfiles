setup_file() {
  ROOT_DIR="$(cd "$BATS_TEST_DIRNAME/../.." && pwd)"
  export ROOT_DIR

  if [[ -z "$HOST" ]]; then
    echo "HOST is required. Usage: HOST=<hostname> bats imac-memory-monitoring.bats" >&2
    exit 1
  fi
}

@test "memory-monitor systemd service exists and wants multi-user.target" {
  result=$(nix develop --command nix eval --impure --expr "
    let flake = builtins.getFlake \"path:$PWD\";
      config = flake.configurations.${HOST}.config;
    in builtins.elem \"multi-user.target\" config.systemd.services.memory-monitor.wantedBy
  ")
  [ "$result" = "true" ]
}

@test "swapDevices is configured with at least one device" {
  result=$(nix develop --command nix eval --impure --expr "
    let flake = builtins.getFlake \"path:$PWD\";
      config = flake.configurations.${HOST}.config;
    in builtins.length config.swapDevices
  ")
  [ "$result" -gt 0 ]
}

@test "journald extraConfig contains Storage=persistent" {
  result=$(nix develop --command nix eval --impure --raw --expr "
    let flake = builtins.getFlake \"path:$PWD\";
      config = flake.configurations.${HOST}.config;
    in config.services.journald.extraConfig
  ")
  [[ "$result" == *"Storage=persistent"* ]]
}

@test "journald extraConfig contains SyncIntervalSec" {
  result=$(nix develop --command nix eval --impure --raw --expr "
    let flake = builtins.getFlake \"path:$PWD\";
      config = flake.configurations.${HOST}.config;
    in config.services.journald.extraConfig
  ")
  [[ "$result" == *"SyncIntervalSec"* ]]
}
