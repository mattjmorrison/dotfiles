{
  user = {
    username = "mmorrison";
    homeDirectory = "/Users/mmorrison";
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

        settings = {
          "sidebar.position_start" = false;
          "sidebar.verticalTabs" = true;
        };
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
