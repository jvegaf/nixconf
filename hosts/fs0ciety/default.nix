{ delib, pkgs, ... }:
delib.host {
  name = "fs0ciety";

  displays = [
    {
      name = "eDP-1";
      refreshRate = 60;
      width = 1920;
      height = 1200;
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
        device = "/dev/nvme0n1";
      };

      hardware = {
        gpu.nvidia = {
          enable = true;
          open = false;
          primeSync = false;
          kernelPackage = "legacy";
        };
        ssd.enable = true;
        bluetooth.enable = true;
        laptop.enable = true;
      };

      swap.enable = true;

      boot = {
        limine = {
          enable = true;
        };
      };

      xdg-portal.enable = true;

      features = {
        nix-enhancement.enable = true;
        cli.enable = true;
        gui.enable = true;
      };

      services = {
        # flatpak.enable = true;
        # nordvpn.enable = true;
        # ollama.enable = true;
        # openssh.enable = true;
        pipewire.enable = true;
        xremap.enable = true;
      };
    };

  nixos = {
    boot = {
      kernelPackages = pkgs.linuxKernel.packages.linux_zen;
      kernelParams = [
        "acpi_backlight=native"
        "iommu=soft"
        "resume_offset=16377208"
      ];
      resumeDevice = "/dev/disk/by-uuid/769e63fb-d3c5-4819-a5a1-10a2bd0a9cb6";
    };

    services.fprintd.enable = true;
  };
}
