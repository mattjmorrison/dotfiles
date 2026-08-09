{ lib, ... }:

{
  system.activationScripts.postActivation.text = lib.mkAfter ''
    if [ -L /etc/hosts ]; then
      rm /etc/hosts
    fi
    {
      echo '127.0.0.1 localhost'
      echo '255.255.255.255 broadcasthost'
      echo '::1 localhost'
    } > /etc/hosts
  '';
}
