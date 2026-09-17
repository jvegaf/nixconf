{
  delib,
  lib,
  ...
}:
delib.module {
  name = "boot";

  nixos.always = {
    boot.plymouth.enable = false;

    boot.loader = {
      systemd-boot.enable = lib.mkDefault true;
      efi.canTouchEfiVariables = true;
    };
  };
}
