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
