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
      profileBookmarks = profile.bookmarks or null;
      profileExtensions = map (extensionName: extensionPackages.${extensionName}) (
        profile.extensions or [ ]
      );
    in
    lib.nameValuePair name (
      {
        inherit id name;
        path = name;
        isDefault = name == settings.firefox.defaultProfile;
        search = {
          default = "ddg";
          privateDefault = "ddg";
          force = true;
        };
      }
      // lib.optionalAttrs (profileBookmarks != null) {
        bookmarks = profileBookmarks;
      }
      // lib.optionalAttrs (profileExtensions != [ ]) {
        extensions.packages = profileExtensions;
      }
      // {
        settings = {
          "sidebar.revamp" = true;
          "sidebar.position_start" = false;
          "sidebar.verticalTabs" = true;
          "sidebar.visibility" = "always-show";
        }
        // profileSettings
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

  # home-manager writes profiles.ini with StartWithLastProfile=1, which makes
  # Firefox open the most-recently-used profile and ignore the Default=1 flag.
  # Replace the symlinked profiles.ini with a copy that sets it to 0 so the
  # profile marked isDefault (sourceallies) is actually used on launch.
  home.activation.firefoxStartWithDefaultProfile = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    PROFILES_INI="$HOME/Library/Application Support/Firefox/profiles.ini"
    if [ -L "$PROFILES_INI" ]; then
      TARGET=$(readlink "$PROFILES_INI")
      rm "$PROFILES_INI"
      /usr/bin/sed 's/StartWithLastProfile=1/StartWithLastProfile=0/' "$TARGET" > "$PROFILES_INI"
    elif [ -f "$PROFILES_INI" ]; then
      /usr/bin/sed -i "" 's/StartWithLastProfile=1/StartWithLastProfile=0/' "$PROFILES_INI"
    fi
  '';
}
