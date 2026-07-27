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
