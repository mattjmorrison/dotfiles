{ settings, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit settings; };

    users.${settings.user.username} = ./home.nix;
  };
}
