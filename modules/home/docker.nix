{ config, ... }:

{
  home.sessionVariables = {
    DOCKER_HOST = "unix://${config.home.homeDirectory}/.colima/default/docker.sock";
  };

  home.file.".docker/config.json".text = builtins.toJSON {
    cliPluginsExtraDirs = [
      "/opt/homebrew/lib/docker/cli-plugins"
    ];
  };
}
