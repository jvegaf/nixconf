{
  inputs,
  self,
  lib,
  ...
}:
{
  flake.nixosConfigurations.surface = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.hostSurface
    ];
  };

  flake.nixosModules.hostSurface =
    {
      pkgs,
      config,
      ...
    }:
    {
      imports = [
        self.nixosModules.base
        self.nixosModules.general
        self.nixosModules.desktop

        self.nixosModules.telegram

        self.nixosModules.powersave
      ];

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      hardware.graphics.enable = true;

      xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
      xdg.portal.enable = true;

      networking.hostName = "surface-pro";

      networking.networkmanager.enable = true;

      boot.kernelPackages = pkgs.linuxPackages_latest;

      system.stateVersion = "25.11";
    };
}
