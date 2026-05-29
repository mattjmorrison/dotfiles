{
  perSystem =
    { pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          bats
          deadnix
          nixfmt
          selene
          shellcheck
          shfmt
          statix
          stylua
          lua-language-server
          neovim
          tmux
        ];
      };

      formatter = pkgs.nixfmt-tree;
    };
}
