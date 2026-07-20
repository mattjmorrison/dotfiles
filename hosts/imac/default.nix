{ inputs, settings, ... }:
{
	imports = [
		./hardware-configuration.nix
		inputs.home-manager.nixosModules.home-manager
	];

	networking.hostName = "imac";
	system.stateVersion = "24.05";
	nixpkgs.config.allowUnfree = true;
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	users.users.${settings.username} = {
		isNormalUser = true;
		extraGroups = [ "wheel" ];
	};
	
	home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
	home-manager.extraSpecialArgs = { inherit inputs settings; };
	home-manager.users.${settings.username} = {
		home.stateVersion = "24.05";
		imports = [ ../../modules/home ];
	};

}
