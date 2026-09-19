{
  delib,
  pkgs,
  inputs,
  ...
}:
delib.module {
  name = "features.gui";

  options = delib.singleEnableOption false;

  myconfig.ifEnabled = {
    services = {
      awww.enable = true;
      dunst.enable = true;
      greetd.enable = true;
    };

    programs = {
      firefox.enable = true;
      niri.enable = true;
      noctalia-shell.enable = true;
    };
  };

  home.ifEnabled.home.packages = with pkgs; [
    tor-browser
  ];
}
