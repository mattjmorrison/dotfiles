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

@test "hosts file maps localhost" {
  actual="$(config_expr 'if (builtins.match ".*127\\.0\\.0\\.1 localhost.*" config.system.activationScripts.postActivation.text) != null then "true" else "false"')"
  assert_true "$actual" "expected /etc/hosts to map 127.0.0.1 to localhost"
}

@test "hosts file no longer hardcodes morrisons.site entries" {
  actual="$(config_expr 'if (builtins.match ".*morrisons\\.site.*" config.system.activationScripts.postActivation.text) != null then "true" else "false"')"
  if [[ "$actual" != "false" ]]; then
    fail "expected /etc/hosts to no longer hardcode morrisons.site entries now that Pi-hole serves them (got: $actual)"
  fi
}
