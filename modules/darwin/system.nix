{ settings, ... }:

{
  system.stateVersion = 6;
  system.primaryUser = settings.user.username;

  programs.zsh.enable = true;
}
