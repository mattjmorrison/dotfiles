{
  lib,
  pkgs,
  settings,
  ...
}:

let
  mkProfile =
    id: name:
    lib.nameValuePair name {
      inherit id name;
      path = name;
      isDefault = name == settings.firefox.defaultProfile;
    };
in

{
  programs.firefox = {
    enable = true;
    package = null;
    release = pkgs.firefox.version;

    profiles = lib.listToAttrs (lib.imap0 mkProfile settings.firefox.profiles);
  };
}
