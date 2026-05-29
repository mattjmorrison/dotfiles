{ settings, ... }:

{
  imports = [
    ../home
  ];

  home.username = settings.user.username;
  home.stateVersion = "26.05";
}
