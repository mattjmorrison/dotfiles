{
  description = "Matt's macOS dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    darwin.url = "github:nix-darwin/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, darwin }:
    let
      system = "aarch64-darwin";
    in {
      darwinConfigurations.macbook =
        darwin.lib.darwinSystem {
          inherit system;

          modules = [
            ./modules/darwin
          ];
        };
    };
}
