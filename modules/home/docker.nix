{ settings, ... }:

{
  home.sessionVariables = {
    DOCKER_HOST = "unix://${settings.user.homeDirectory}/.colima/default/docker.sock";
  };

  home.file.".docker/config.json".text = builtins.toJSON {
    cliPluginsExtraDirs = [
      "/opt/homebrew/lib/docker/cli-plugins"
    ];
  };
}
