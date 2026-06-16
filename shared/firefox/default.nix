{
  profiles = {
    mattjmorrison = import ./profiles/mattjmorrison.nix;
    pyowa = import ./profiles/pyowa.nix;
    sourceallies = import ./profiles/sourceallies.nix;
  };

  profileOrder = [
    "mattjmorrison"
    "pyowa"
    "sourceallies"
  ];
}
