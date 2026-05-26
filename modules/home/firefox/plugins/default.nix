{ pkgs }:

{
  bitwarden = import ./bitwarden.nix { inherit pkgs; };
}
