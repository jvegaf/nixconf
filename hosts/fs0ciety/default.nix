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
        # gui.enable = true;
      };

      programs.xfce.enable = true;

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
    environment.shellAliases = {
      freb = "sudo nixos-rebuild switch --flake ~/nixconf#fs0ciety --log-format internal-json -v |& nom --json";
    };
  };
}
