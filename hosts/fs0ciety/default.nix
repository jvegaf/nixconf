{ delib, pkgs, ... }:

delib.host {
  name = "fs0ciety";

  displays = [
    # {
    #   name = "HDMI-A-1";
    #   refreshRate = 60;
    #   width = 1920;
    #   height = 1080;
    #   x = 3440;
    #   y = 0;
    # }
    {
      name = "eDP-1";
      refreshRate = 60;
      width = 1920;
      height = 1080;
      x = 0;
      y = 0;
    }
  ];

  myconfig =
    { name, ... }:
    {
      args.shared.hostName = name;

      hardware = {
        # cpu.intel.enable = true;
        gpu.nvidia = {
          enable = true;
          open = false;
          primeSync = false;
          kernelPackage = "legacy";
        };
        ssd.enable = true;
      };

      bluetooth.enable = true;

      # swap.enable = false;

      boot = {
        zswap.enable = false;
        limine.enable = true;
      };

      # features = {
      #   nix-enhancement.enable = true;
      #   cli.enable = true;
      #   gui.enable = true;
      # };

      services = {
        displayManager.ly.enable = true;
        openssh.enable = true;
        pipewire.enable = true;
      };
    };

  nixos = {
    boot.kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
  };
}
