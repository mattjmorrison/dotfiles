{
  description = "Matt's macOS dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    darwin.url = "github:nix-darwin/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, darwin, home-manager }:
    let
      system = "aarch64-darwin";
    in {
      darwinConfigurations.macbook =
        darwin.lib.darwinSystem {
          inherit system;

          modules = [
		  ./modules/darwin
		  home-manager.darwinModules.home-manager
      {
        nixpkgs.config.allowUnfreePredicate = pkg:
          builtins.elem (nixpkgs.lib.getName pkg) [
            "claude-code"
            "github-copilot-cli"
          ];
      }
		  {
		    home-manager.useGlobalPkgs = true;
		    home-manager.useUserPackages = true;
                    home-manager.backupFileExtension = "backup";
                    home-manager.users."matt-nix" = ./home/matt-nix.nix;
		  }
		];
        };
    };
}
