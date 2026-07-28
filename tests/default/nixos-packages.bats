@test "ghostty terminfo is installed" {
  result=$(nix develop --command nix eval --impure --expr "
    let flake = builtins.getFlake \"path:$PWD\";
      config = flake.configurations.${HOST}.config;
    in builtins.any (p: (p.pname or \"\") == \"ghostty\") config.environment.systemPackages
  ")
  [ "$result" = "true" ]
}
