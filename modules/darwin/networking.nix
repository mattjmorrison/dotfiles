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
      echo
      echo '192.168.86.72 argocd.morrisons.site'
      echo '192.168.86.72 prometheus.morrisons.site'
      echo '192.168.86.72 alertmanager.morrisons.site'
      echo '192.168.86.72 grafana.morrisons.site'
      echo '192.168.86.72 openbao.morrisons.site'
    } > /etc/hosts
  '';
}
