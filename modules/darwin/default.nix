
{ pkgs, ... }:

{
  nix.enable = false;

  system.stateVersion = 6;
  system.primaryUser = "matt-nix";
  programs.zsh.enable = true;
  users.users."matt-nix".home = "/Users/matt-nix";

  homebrew = {
    enable = true;

    casks = [
      "ghostty"
      "karabiner-elements"
      "rectangle"
      "firefox@developer-edition"
    ];
  };
}
