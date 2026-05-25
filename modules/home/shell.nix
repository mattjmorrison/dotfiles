{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tmux
  ];

  home.file.".tmux.conf".source = ../../config/tmux/tmux.conf;

  xdg.configFile."ghostty/config.ghostty".text = ''
    theme = TokyoNight Night
  '';

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = builtins.readFile ../../config/zsh/aliases.zsh;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
