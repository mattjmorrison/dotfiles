{ pkgs, ... }:

{
  home.file.".config/karabiner/karabiner.json".text =
   builtins.toJSON {
    profiles = [
      {
        name = "Default";
        selected = true;

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
  };
}
