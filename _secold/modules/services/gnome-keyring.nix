{ delib, host, ... }:
delib.module {
  name = "services.gnome-keyring";

  options = delib.singleEnableOption false;

  home.ifEnabled.services.gnome-keyring.enable = true;
}
