{ delib, pkgs, ... }:

delib.host {
  name = "blade";

  displays = [
    {
      name = "HDMI-A-1";
      refreshRate = 60;
      width = 1920;
      height = 1080;
      x = 3440;
      y = 0;
    }
    {
      name = "eDP-1";
      refreshRate = 60;
      width = 3440;
      height = 1440;
      x = 0;
      y = 0;
    }
  ];

  myconfig =
    { name, ... }:
    {
      args.shared.hostName = name;

      hardware = {
        cpu.intel.enable = true;
        gpu.nvidia = {
          enable = true;
          open = true;
          primeSync = true;
          kernelPackage = "latest";
        };
        ssd.enable = true;
        bluetooth.enable = true;
      };

      swap.enable = false;

      boot = {
        zswap.enable = false;
        limine.enable = true;
      };

      xdg-portal.enable = true;

      features = {
        nix-enhancement.enable = true;
        cli.enable = true;
        gui.enable = true;
      };

      services = {
        displayManager.ly.enable = true;
        openssh.enable = true;
        pipewire.enable = true;
      };
    };

  nixos = {
    boot.kernelPackages = pkgs.linuxPackages_latest;
  };
}
