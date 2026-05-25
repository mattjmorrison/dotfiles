{ pkgs, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      init.defaultBranch = "main";

      user = {
        name = "Matt Morrison";
        email = "mattjmorrison@mattjmorrison.com";
      };

      push = {
        autoSetupRemote = true;
      };

      core = {
        editor = "nvim";
      };
    };
  };
  home.packages = with pkgs; [
    gh
    lazygit
  ];
}
