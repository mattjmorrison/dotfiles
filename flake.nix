{
  description = "Matt's macOS dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    darwin.url = "github:nix-darwin/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs =
    inputs@{ darwin, nixpkgs, ... }:
    let
      system = "aarch64-darwin";
      pkgs = import nixpkgs { inherit system; };
      settings = import ./settings.nix;
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          bats
          deadnix
          nixfmt
          selene
          shellcheck
          shfmt
          statix
          stylua
          lua-language-server
          neovim
          tmux
        ];
      };

      formatter.${system} = pkgs.nixfmt-tree;

      darwinConfigurations.macbook = darwin.lib.darwinSystem {
        inherit system;
        specialArgs = { inherit inputs settings; };

        modules = [
          ./hosts/macbook
        ];
      };
    };
}
