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

    homelab.url = "github:mattjmorrison/homelab";
  };

  outputs =
    inputs:
    let
      darwin = "aarch64-darwin";
      linux = "x86_64-linux";
    in
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        darwin
        linux
      ];

      imports = [ ./dev/shell.nix ];

      flake =
        let
          lib = inputs.nixpkgs.lib;
          allHosts = builtins.attrNames (lib.filterAttrs (_: v: v == "directory") (builtins.readDir ./hosts));
          darwinHosts = builtins.filter (h: h != "imac") allHosts;
          mkConfig =
            host:
            inputs.darwin.lib.darwinSystem {
              system = darwin;
              specialArgs = {
                inherit inputs;
                settings = import ./hosts/${host}/settings.nix;
              };
              modules = [ ./hosts/${host} ];
            };
          nixosConfigurations = {
            imac = inputs.nixpkgs.lib.nixosSystem {
              system = linux;
              specialArgs = {
                inherit inputs;
                settings = import ./hosts/imac/settings.nix;
              };
              modules = [ ./hosts/imac ];
            };
          };
        in
        {
          darwinConfigurations = lib.genAttrs darwinHosts mkConfig;
          inherit nixosConfigurations;
          configurations = (lib.genAttrs darwinHosts mkConfig) // nixosConfigurations;
          checks = {
            x86_64-linux = {
              imac-uses-k3s =
                let
                  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
                  enabled = nixosConfigurations.imac.config.services.k3s.enable;
                in
                pkgs.runCommand "imac-uses-k3s" { } (
                  if enabled then "touch $out" else "echo 'imac: services.k3s.enable is false' >&2; exit 1"
                );
            };
          };
        };
    };
}
