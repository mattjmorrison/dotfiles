{ ... }:

{
  imports = [
    ../../modules/macbook
  ];

  # Enable Prometheus node_exporter on this host only; port 9100 is nix-darwin's default
  services.prometheus.exporters.node.enable = true;
}
