
{ pkgs, ... }:

{
	nix.enable = false;
	system.stateVersion = 6;
	system.primaryUser = "matt-nix";
	programs.zsh.enable = true;
	environment.systemPackages = with pkgs; [
		git
	];


	homebrew = {
	  enable = true;

	  casks = [
	    "ghostty"
	  ];
	};
}

