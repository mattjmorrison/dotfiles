{ lib, pkgs, ... }:

let
  karabinerConfig = pkgs.writeText "karabiner.json" (
    builtins.toJSON {
      profiles = [
        {
          name = "Default";
          selected = true;

          virtual_hid_keyboard.keyboard_type_v2 = "ansi";

          complex_modifications.rules = [
            {
              description = "Caps Lock to Escape";
              manipulators = [
                {
                  type = "basic";

                  from = {
                    key_code = "caps_lock";

                    modifiers.optional = [ "any" ];
                  };

                  to = [
                    {
                      key_code = "left_control";
                    }
                  ];

                  to_if_alone = [
                    {
                      key_code = "escape";
                    }
                  ];

                  parameters = {
                    basic.to_if_alone_timeout_milliseconds = 250;
                  };
                }
              ];
            }
          ];
        }
      ];
    }
  );
in
{
  # Karabiner Elements must own its config file directly — it cannot follow symlinks
  # into the Nix store due to macOS sandbox restrictions. We copy on activation instead.
  home.activation.karabiner = lib.mkIf pkgs.stdenv.isDarwin (
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      $DRY_RUN_CMD mkdir -p "$HOME/.config/karabiner"
      $DRY_RUN_CMD cp --no-preserve=mode,ownership ${karabinerConfig} "$HOME/.config/karabiner/karabiner.json"
    ''
  );
}
