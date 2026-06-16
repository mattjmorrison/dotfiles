{ pkgs }:

let
  themeId = "7f63e4ea-40b7-4a72-a860-4138af1b9789";
  firefoxAppId = "{ec8030f7-c20a-464f-9b0e-13a3a9e97384}";
in
pkgs.stdenvNoCC.mkDerivation {
  pname = "firefox-theme-sourceallies";
  version = "1.0";

  addonId = "{${themeId}}";
  passthru.addonId = "{${themeId}}";

  src = ./sourceallies.xpi;

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    install -Dm644 "$src" "$out/share/mozilla/extensions/${firefoxAppId}/{${themeId}}.xpi"

    runHook postInstall
  '';
}
