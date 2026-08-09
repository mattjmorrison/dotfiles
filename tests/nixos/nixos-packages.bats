setup_file() {
  ROOT_DIR="$(cd "$BATS_TEST_DIRNAME/../.." && pwd)"
  export ROOT_DIR

  if [[ -z "$HOST" ]]; then
    echo "HOST is required. Usage: HOST=<hostname> bats nixos-packages.bats" >&2
    exit 1
  fi
}

@test "nano is disabled" {
  result=$(nix develop --command nix eval --impure --expr "
    let flake = builtins.getFlake \"path:$PWD\";
      config = flake.configurations.${HOST}.config;
    in config.programs.nano.enable
  ")
  [ "$result" = "false" ]
}

@test "EDITOR system variable is set to nvim" {
  result=$(nix develop --command nix eval --impure --raw --expr "
    let flake = builtins.getFlake \"path:$PWD\";
      config = flake.configurations.${HOST}.config;
    in config.environment.variables.EDITOR
  ")
  [ "$result" = "nvim" ]
}

@test "ghostty terminfo is installed" {
  result=$(nix develop --command nix eval --impure --expr "
    let flake = builtins.getFlake \"path:$PWD\";
      config = flake.configurations.${HOST}.config;
    in builtins.any (p: (p.pname or \"\") == \"ghostty\") config.environment.systemPackages
  ")
  [ "$result" = "true" ]
}

@test "k9s is installed" {
  result=$(nix develop --command nix eval --impure --expr "
    let flake = builtins.getFlake \"path:$PWD\";
      config = flake.configurations.${HOST}.config;
    in builtins.any (p: (p.pname or \"\") == \"k9s\") config.environment.systemPackages
  ")
  [ "$result" = "true" ]
}

@test "KUBECONFIG env var is set to /etc/rancher/k3s/k3s.yaml" {
  result=$(nix develop --command nix eval --impure --raw --expr "
    let flake = builtins.getFlake \"path:$PWD\";
      config = flake.configurations.${HOST}.config;
    in config.environment.variables.KUBECONFIG
  ")
  [ "$result" = "/etc/rancher/k3s/k3s.yaml" ]
}

@test "firewall allows TCP port 6443" {
  result=$(nix develop --command nix eval --impure --expr "
    let flake = builtins.getFlake \"path:$PWD\";
      config = flake.configurations.${HOST}.config;
    in builtins.elem 6443 config.networking.firewall.allowedTCPPorts
  ")
  [ "$result" = "true" ]
}

@test "k3s role is server" {
  result=$(nix develop --command nix eval --impure --raw --expr "
    let flake = builtins.getFlake \"path:$PWD\";
      config = flake.configurations.${HOST}.config;
    in config.services.k3s.role
  ")
  [ "$result" = "server" ]
}

@test "firewall allows TCP port 53" {
  result=$(nix develop --command nix eval --impure --expr "
    let flake = builtins.getFlake \"path:$PWD\";
      config = flake.configurations.${HOST}.config;
    in builtins.elem 53 config.networking.firewall.allowedTCPPorts
  ")
  [ "$result" = "true" ]
}

@test "firewall allows UDP port 53" {
  result=$(nix develop --command nix eval --impure --expr "
    let flake = builtins.getFlake \"path:$PWD\";
      config = flake.configurations.${HOST}.config;
    in builtins.elem 53 config.networking.firewall.allowedUDPPorts
  ")
  [ "$result" = "true" ]
}

@test "firewall allows TCP port 8080" {
  result=$(nix develop --command nix eval --impure --expr "
    let flake = builtins.getFlake \"path:$PWD\";
      config = flake.configurations.${HOST}.config;
    in builtins.elem 8080 config.networking.firewall.allowedTCPPorts
  ")
  [ "$result" = "true" ]
}
