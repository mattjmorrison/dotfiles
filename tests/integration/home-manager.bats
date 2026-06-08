#!/usr/bin/env bats

setup_file() {
  ROOT_DIR="$(cd "$BATS_TEST_DIRNAME/../.." && pwd)"
  export ROOT_DIR

  if [[ -z "$HOST" ]]; then
    echo "HOST is required. Usage: HOST=<username> bats home-manager.bats" >&2
    exit 1
  fi
}

config_expr() {
  local expr="$1"

  nix eval --impure --expr "
    let
      flake = builtins.getFlake \"$ROOT_DIR\";
      config = flake.darwinConfigurations.${HOST}.config;
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

@test "home-manager uses global pkgs" {
  actual="$(config_expr 'if config.home-manager.useGlobalPkgs then "true" else "false"')"
  assert_true "$actual" "expected useGlobalPkgs to be true"
}

@test "home-manager uses user packages" {
  actual="$(config_expr 'if config.home-manager.useUserPackages then "true" else "false"')"
  assert_true "$actual" "expected useUserPackages to be true"
}

@test "home-manager backup extension is set" {
  actual="$(config_expr 'config.home-manager.backupFileExtension')"
  [ "$actual" = "backup" ]
}

@test "home-manager user is configured for host" {
  actual="$(config_expr "if config.home-manager.users ? \"${HOST}\" then \"true\" else \"false\"")"
  assert_true "$actual" "expected home-manager to have a user configured for ${HOST}"
}

@test "home-manager manages .docker/config.json" {
  actual="$(config_expr "if config.home-manager.users.\"${HOST}\".home.file ? \".docker/config.json\" then \"true\" else \"false\"")"
  [ "$actual" = "true" ]
}

@test ".docker/config.json registers homebrew compose plugin path" {
  actual="$(config_expr "config.home-manager.users.\"${HOST}\".home.file.\".docker/config.json\".text")"
  [[ "$actual" == *"cliPluginsExtraDirs"* ]]
  [[ "$actual" == *"/opt/homebrew/lib/docker/cli-plugins"* ]]
}

@test "DOCKER_HOST is set to colima socket" {
  actual="$(config_expr "config.home-manager.users.\"${HOST}\".home.sessionVariables.DOCKER_HOST")"
  [ "$actual" = "unix:///Users/${HOST}/.colima/default/docker.sock" ]
}
