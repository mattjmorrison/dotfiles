{ settings, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    backupCommand = ''mv "$1" "$1.$(date +%s)"'';
    extraSpecialArgs = { inherit settings; };

    users.${settings.user.username} = ./home.nix;
  };
}
