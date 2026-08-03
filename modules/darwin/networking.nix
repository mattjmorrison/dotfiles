_:

{
  environment.etc."hosts".text = ''
    127.0.0.1 localhost
    255.255.255.255 broadcasthost
    ::1 localhost

    192.168.86.72 argocd.morrisons.site
  '';
}
