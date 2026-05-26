{
  lib,
  pkgs,
  settings,
  ...
}:

let
  extensionPackages = import ./firefox/plugins { inherit pkgs; };

  mkProfile =
    id: name:
    let
      profile = settings.firefox.profiles.${name} or { };
      profileSettings = profile.settings or { };
      profileExtensions = map (extensionName: extensionPackages.${extensionName}) (
        profile.extensions or [ ]
      );
    in
    lib.nameValuePair name (
      {
        inherit id name;
        path = name;
        isDefault = name == settings.firefox.defaultProfile;
      }
      // lib.optionalAttrs (profileExtensions != [ ]) {
        extensions.packages = profileExtensions;
      }
      // {
        settings =
          profileSettings
          // lib.optionalAttrs (profileExtensions != [ ]) {
            "extensions.autoDisableScopes" = 0;
          };
      }
    );
in

{
  programs.firefox = {
    enable = true;
    package = null;
    release = pkgs.firefox.version;

    profiles = lib.listToAttrs (lib.imap0 mkProfile settings.firefox.profileOrder);
  };
}
