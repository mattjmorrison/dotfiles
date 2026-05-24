{ inputs, ... }:

{
  imports = [
    ../../modules/darwin
    inputs.home-manager.darwinModules.home-manager
    ./home-manager.nix
  ];
}
