{
  description = "Matt's macOS dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    darwin.url = "github:nix-darwin/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs:
    let
      system = "aarch64-darwin";
    in
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ system ];

      imports = [ ./dev/shell.nix ];

      flake =
        let
          lib = inputs.nixpkgs.lib;
          hosts = builtins.attrNames (lib.filterAttrs (_: v: v == "directory") (builtins.readDir ./hosts));
          mkConfig =
            host:
            inputs.darwin.lib.darwinSystem {
              inherit system;
              specialArgs = {
                inherit inputs;
                settings = import ./hosts/${host}/settings.nix;
              };
              modules = [ ./hosts/${host} ];
            };
        in
        {
          darwinConfigurations = lib.genAttrs hosts mkConfig;
        };
    };
}
