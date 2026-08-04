#!/usr/bin/env bats

setup_file() {
  ROOT_DIR="$(cd "$BATS_TEST_DIRNAME/../.." && pwd)"
  export ROOT_DIR

  if [[ -z "$HOST" ]]; then
    echo "HOST is required. Usage: HOST=<username> bats darwin-networking.bats" >&2
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

@test "hosts file maps 192.168.86.72 to argocd.morrisons.site" {
  actual="$(config_expr 'if (builtins.match ".*192\\.168\\.86\\.72 argocd\\.morrisons\\.site.*" config.system.activationScripts.postActivation.text) != null then "true" else "false"')"
  assert_true "$actual" "expected /etc/hosts to map 192.168.86.72 to argocd.morrisons.site"
}

@test "hosts file maps 192.168.86.72 to prometheus.morrisons.site" {
  actual="$(config_expr 'if (builtins.match ".*192\\.168\\.86\\.72 prometheus\\.morrisons\\.site.*" config.system.activationScripts.postActivation.text) != null then "true" else "false"')"
  assert_true "$actual" "expected /etc/hosts to map 192.168.86.72 to prometheus.morrisons.site"
}

@test "hosts file maps 192.168.86.72 to alertmanager.morrisons.site" {
  actual="$(config_expr 'if (builtins.match ".*192\\.168\\.86\\.72 alertmanager\\.morrisons\\.site.*" config.system.activationScripts.postActivation.text) != null then "true" else "false"')"
  assert_true "$actual" "expected /etc/hosts to map 192.168.86.72 to alertmanager.morrisons.site"
}

@test "hosts file maps 192.168.86.72 to grafana.morrisons.site" {
  actual="$(config_expr 'if (builtins.match ".*192\\.168\\.86\\.72 grafana\\.morrisons\\.site.*" config.system.activationScripts.postActivation.text) != null then "true" else "false"')"
  assert_true "$actual" "expected /etc/hosts to map 192.168.86.72 to grafana.morrisons.site"
}
