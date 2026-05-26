{ settings, ... }:

{
  imports = [
    ../../modules/home
  ];

  home.username = settings.user.username;
  home.stateVersion = "26.05";
}
