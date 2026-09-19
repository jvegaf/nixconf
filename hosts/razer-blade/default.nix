{ delib, pkgs, ... }:

delib.host {
  name = "razer-blade";

  displays = [
    {
      name = "eDP-1";
      refreshRate = 60;
      width = 2560;
      height = 1440;
      x = 0;
      y = 0;
    }
  ];

  myconfig =
    { name, ... }:
    {
      args.shared.hostName = name;

      disko = {
        enable = true;
        device = "/dev/disk/by-id/nvme-CT500P1SSD8_2004E284F1D7";
      };

      hardware = {
        # cpu.intel.enable = true;
        gpu.nvidia = {
          enable = true;
          open = true;
          primeSync = true;
          kernelPackage = "latest";
        };
        bluetooth.enable = true;
        ssd.enable = true;
      };

      # swap.enable = false;

      boot = {
        limine.enable = true;
      };

      features = {
        nix-enhancement.enable = true;
        cli.enable = true;
        gui.enable = true;
      };

      services = {
        openssh.enable = true;
        pipewire.enable = true;
      };
    };

  nixos = {
    boot.kernelPackages = pkgs.linuxPackages_latest;
  };
}
