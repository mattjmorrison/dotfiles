{ pkgs }:

{
  bitwarden = import ./bitwarden.nix { inherit pkgs; };
  clerks-theme = import ./clerks.nix { inherit pkgs; };
  sourceallies-theme = import ./sourceallies.nix { inherit pkgs; };
}
