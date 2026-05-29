{ inputs, settings, ... }:

{
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
    ../darwin
    inputs.home-manager.darwinModules.home-manager
    ./home-manager.nix
  ];

  nix-homebrew = {
    enable = true;
    user = settings.user.username;
    autoMigrate = true;
  };
}
