{ settings, ... }: {
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  users.users.${settings.username}.openssh.authorizedKeys.keys = [
    settings.user.publicKey
  ];
}
