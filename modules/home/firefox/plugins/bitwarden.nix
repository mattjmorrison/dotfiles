{
  pkgs,
}:

let
  bitwardenExtensionId = "446900e4-71c2-419f-a6a7-df9c091e268b";
  firefoxAppId = "{ec8030f7-c20a-464f-9b0e-13a3a9e97384}";
in
pkgs.stdenvNoCC.mkDerivation {
  pname = "firefox-extension-bitwarden-password-manager";
  version = "2026.4.0";

  addonId = "{${bitwardenExtensionId}}";
  passthru.addonId = "{${bitwardenExtensionId}}";

  src = pkgs.fetchurl {
    url = "https://addons.mozilla.org/firefox/downloads/file/4796063/bitwarden_password_manager-2026.4.0.xpi";
    sha256 = "045ffhr158lnafwdpyijhwnzzjf42rgwzpwvzva5b1hwl71zdgfc";
  };

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    install -Dm644 "$src" "$out/share/mozilla/extensions/${firefoxAppId}/{${bitwardenExtensionId}}.xpi"

    runHook postInstall
  '';

  meta.mozPermissions = [
    "<all_urls>"
    "*://*/*"
    "alarms"
    "clipboardRead"
    "clipboardWrite"
    "contextMenus"
    "idle"
    "storage"
    "tabs"
    "unlimitedStorage"
    "webNavigation"
    "webRequest"
    "webRequestBlocking"
    "notifications"
  ];
}
