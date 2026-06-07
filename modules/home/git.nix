{ pkgs, settings, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      init.defaultBranch = "main";

      user = {
        name = settings.user.fullName;
        email = settings.user.email;
      };

      push = {
        autoSetupRemote = true;
      };

      core = {
        editor = "nvim";
      };
    };
  };
  programs.lazygit = {
    enable = true;
    settings = {
      keybinding = {
        universal = {
          focusMainView = "<c-l>";
        };
      };
    };
  };

  home.packages = with pkgs; [
    gh
  ];
}
