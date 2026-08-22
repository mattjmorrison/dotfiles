#!/usr/bin/env bats

setup_file() {
  ROOT_DIR="$(cd "$BATS_TEST_DIRNAME/../.." && pwd)"
  export ROOT_DIR

  if [[ -z "$HOST" ]]; then
    echo "HOST is required. Usage: HOST=<username> bats matt-nix-node-exporter.bats" >&2
    exit 1
  fi
}

config_expr() {
  local expr="$1"

  nix eval --impure --expr "
    let
      flake = builtins.getFlake \"$ROOT_DIR\";
      config = flake.configurations.${HOST}.config;
    in
      ${expr}
  " --raw
}

assert_true() {
  local actual="$1"
  local message="$2"

  if [[ "$actual" != "true" ]]; then
    fail "$message (got: $actual)"
  fi
}

@test "node_exporter is enabled" {
  actual="$(config_expr 'if config.services.prometheus.exporters.node.enable then "true" else "false"')"
  assert_true "$actual" "expected services.prometheus.exporters.node.enable to be true"
}

@test "node_exporter excludes mount points" {
  actual="$(config_expr 'if builtins.any (f: builtins.match ".*mount-points-exclude.*" f != null) config.services.prometheus.exporters.node.extraFlags then "true" else "false"')"
  assert_true "$actual" "expected services.prometheus.exporters.node.extraFlags to contain a mount-points-exclude flag"
}
