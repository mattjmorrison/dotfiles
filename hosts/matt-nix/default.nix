{ ... }:

{
  imports = [
    ../../modules/macbook
  ];

  # Enable Prometheus node_exporter on this host only; port 9100 is nix-darwin's default
  services.prometheus.exporters.node = {
    enable = true;
    # Exclude APFS synthetic mounts and /dev; without this, macOS APFS
    # containers share free-space accounting across volumes, producing
    # duplicate/incorrect disk-usage percentages in Grafana.
    extraFlags = [
      "--collector.filesystem.mount-points-exclude=^/(System/Volumes/.*|dev)($|/)"
    ];
  };
}
