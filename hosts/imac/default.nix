{
  inputs,
  settings,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    ../../modules/nixos/ssh.nix
    inputs.homelab.nixosModules.k3s-control-plane
  ];

  environment.systemPackages = [ pkgs.ghostty ];

  programs.nano.enable = false;

  environment.variables = {
    EDITOR = "nvim";
  };

  networking.hostName = "imac";
  system.stateVersion = "24.05";
  nixpkgs.config.allowUnfree = true;
  virtualisation.docker.enable = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  services = {
    # Enable mDNS NSS module for .local hostname resolution (required by Prometheus and other apps to reach pi5-*.local)
    avahi.nssmdns4 = true;
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
    journald.extraConfig = ''
      Storage=persistent
      SyncIntervalSec=5s
    '';
  };
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  users.users.${settings.user.username} = {
    isNormalUser = true;
    # Allow unprivileged access to the Docker daemon
    extraGroups = [
      "wheel"
      "docker"
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs settings; };
    users.${settings.user.username} = {
      home.stateVersion = "24.05";
      imports = [ ../../modules/home ];
    };
  };

  swapDevices = [
    {
      device = "/swapfile";
      size = 16384;
    }
  ];

  systemd.services.memory-monitor = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Restart = "always";
      Type = "simple";
      ExecStart = pkgs.writeShellScript "memory-monitor" ''
        while true; do
          echo "=== $(${pkgs.coreutils}/bin/date) ==="
          ${pkgs.procps}/bin/free -m
          echo "--- Top 15 processes by RSS ---"
          ${pkgs.procps}/bin/ps aux --sort=-rss | head -16
          sleep 30
        done
      '';
    };
  };

}
