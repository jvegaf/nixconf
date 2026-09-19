{
  delib,
  ...
}:
delib.module {
  name = "services.displayManager.gdm";
  options = delib.singleEnableOption false;

  nixos.ifEnabled = { ... }: {

    services.displayManager.sddm.enable = false;
    services.displayManager.gdm.enable = true;

  };
}
