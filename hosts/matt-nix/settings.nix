{
  user = {
    username = "matt-nix";
    homeDirectory = "/Users/matt-nix";
    fullName = "Matt Morrison";
    email = "mattjmorrison@mattjmorrison.com";
  };

  firefox = (import ../../shared/firefox) // {
    defaultProfile = "mattjmorrison";
  };
}
