{
  user = {
    username = "mmorrison";
    homeDirectory = "/Users/mmorrison";
    fullName = "Matt Morrison";
    email = "mattjmorrison@mattjmorrison.com";
  };

  firefox = (import ../../shared/firefox) // {
    defaultProfile = "mattjmorrison";
  };
}
