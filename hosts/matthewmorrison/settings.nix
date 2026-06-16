{
  user = {
    username = "matthewmorrison";
    homeDirectory = "/Users/matthewmorrison";
    fullName = "Matt Morrison";
    email = "mattjmorrison@mattjmorrison.com";
  };

  firefox = (import ../../shared/firefox) // {
    defaultProfile = "mattjmorrison";
  };
}
