{
  delib,
  inputs,
  pkgs,
  ...
}:
delib.module {
  name = "hardware.razer";

  options.hardware.razer = with delib; {
    enable = boolOption false;
    user = strOption "foo";
    open = boolOption false;
    primeSync = boolOption false;
    kernelPackage = listOfOption str [
      "legacy"
      "latest"
      "stable"
    ];
  };

  nixos.always = { ... }: {
    imports = [
      inputs.razerdaemon.nixosModules.default
    ];
  };

  nixos.ifEnabled =
    { cfg, ... }:
    {

      services.razer-laptop-control.enable = true;

      hardware = {
        # Razer-specific utilities
        openrazer = {
          enable = true;
          users = [ cfg.user ]; # Adjust to your username
          syncEffectsEnabled = true;
          devicesOffOnScreensaver = true;
          batteryNotifier = {
            enable = true;
            frequency = 600;
            percentage = 33;
          };
        };
        enableRedistributableFirmware = true;
      };

      environment.systemPackages = with pkgs; [
        libva
        libva-utils
        # Utilidades Razer
        openrazer-daemon
        polychromatic
      ];
    };
}
