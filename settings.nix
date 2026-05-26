{
  user = {
    username = "matt-nix";
    homeDirectory = "/Users/matt-nix";
    fullName = "Matt Morrison";
    email = "mattjmorrison@mattjmorrison.com";
  };

  firefox = {
    defaultProfile = "mattjmorrison";
    profiles = {
      mattjmorrison = {
        extensions = [
          "bitwarden"
        ];
      };

      pyowa = { };

      sourceallies = { };
    };

    profileOrder = [
      "mattjmorrison"
      "pyowa"
      "sourceallies"
    ];
  };
}
