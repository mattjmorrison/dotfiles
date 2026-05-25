{ lib, ... }:

{
  nix.enable = false;

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "claude-code"
      "github-copilot-cli"
    ];
}
