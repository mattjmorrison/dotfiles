{ settings, ... }:

{
  users.users.${settings.user.username}.home = settings.user.homeDirectory;
}
