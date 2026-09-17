{
  delib,
  ...
}:
delib.module {
  name = "services.displayManager.ly";
  options = delib.singleEnableOption true;

  nixos.ifEnabled = { ... }: {

    services.displayManager.sddm.enable = false;
    services.displayManager.gdm.enable = false;

    services.displayManager.ly = {
      enable = true;
      settings = {
        animation = "matrix";
        bigclock = "en";
        vi_mode = true;
        vi_default_mode = "insert";
        blank_box = true;
        hide_key_hints = false;
        load = true;
        save = true;
        clear_password = false;
      };
    };
  };
}
