{
  delib,
  ...
}:
delib.module {
  name = "services.displayManager.sddm";
  options = delib.singleEnableOption false;

  nixos.ifEnabled = { ... }: {

    services.displayManager.sddm.enable = true;
    services.displayManager.gdm.enable = false;

  };
}
