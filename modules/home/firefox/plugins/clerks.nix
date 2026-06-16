{ pkgs }:

let
  themeId = "6ee4d20b-b7c1-4048-bffb-c31a9a0db5b3";
  firefoxAppId = "{ec8030f7-c20a-464f-9b0e-13a3a9e97384}";
in
pkgs.stdenvNoCC.mkDerivation {
  pname = "firefox-theme-clerks";
  version = "5.0";

  addonId = "{${themeId}}";
  passthru.addonId = "{${themeId}}";
  src = ./clerks.xpi;

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    install -Dm644 "$src" "$out/share/mozilla/extensions/${firefoxAppId}/{${themeId}}.xpi"

    runHook postInstall
  '';
}
