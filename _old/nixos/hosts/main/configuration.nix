{
  inputs,
  self,
  ...
}:
{
  flake.nixosConfigurations.main = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.hostMain
    ];
  };

  flake.nixosModules.hostMain =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    let
      selfpkgs = self.packages."${pkgs.stdenv.hostPlatform.system}";
    in
    {
      imports = [
        self.nixosModules.base
        self.nixosModules.general
        self.nixosModules.desktop

        self.nixosModules.impermanence

        # self.nixosModules.gimp
        # self.nixosModules.telegram
        # self.nixosModules.youtube-music

        # self.nixosModules.powersave

        # self.nixosModules.virt

        # disko
        inputs.disko.nixosModules.disko
        self.diskoConfigurations.hostMain
      ];

      # programs.corectrl.enable = true;

      boot = {
        kernelPackages = pkgs.linuxPackages_latest;

        # loader.grub.enable = true;
        # loader.grub.efiInstallAsRemovable = true;
        loader.systemd-boot.enable = true;
        loader.efi.canTouchEfiVariables = true;

        # supportedFilesystems.ntfs = true;

        # kernelParams = ["quiet" "amd_pstate=guided" "processor.max_cstate=1"];
        # kernelParams = [ "quiet" ];
        # kernelModules = [
        #   "mt7921e"
        #   "coretemp"
        #   "cpuid"
        #   "v4l2loopback"
        #   "nct6687"
        # ];

        initrd.availableKernelModules = [
          "xhci_pci"
          "nvme"
          "usbhid"
          "usb_storage"
          "sd_mod"
          "rtsx_pci_sdmmc"
        ];
        kernelModules = [ "kvm-intel" ];
        extraModulePackages = [ ];

      };

      boot.plymouth.enable = false;

      networking = {
        hostName = "main";
        networkmanager.enable = true;
      };

      hardware.cpu.intel.updateMicrocode = true;

      services = {
        hardware.openrgb.enable = false;
        flatpak.enable = false;
        udisks2.enable = true;
        printing.enable = false;
      };

      # programs.alvr.enable = true;
      # programs.alvr.openFirewall = true;

      environment.systemPackages = with pkgs; [
        pciutils
        lshw
        nmap
        curl
        ntfs3g
        wget
        p7zip
        lm_sensors
        vim
        # winetricks
        # glib
        #
        # bs-manager
        #
        # zerotierone
        #
        # android-tools
        # self.packages."${pkgs.stdenv.hostPlatform.system}".ask
      ];

      xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      xdg.portal.enable = true;

      # hjem.users.${config.preferences.user.name}.files.".config/xdg-desktop-portal-wlr/config".text = ''
      #   [screencast]
      #   chooser_type=dmenu
      #   chooser_cmd=${selfpkgs.vjSharePicker}/bin/vjSharePicker
      # '';

      hardware = {
        enableRedistributableFirmware = true;
        nvidia = {
          open = true;
          nvidiaSettings = true;
          package = config.boot.kernelPackages.nvidiaPackages.stable;
          prime = {
            offload.enable = false;
            sync.enable = true;
            intelBusId = "PCI:0:2:0";
            nvidiaBusId = "PCI:1:0:0";
          };
        };
        graphics = {
          enable = true;
          enable32Bit = true;
        };
        bluetooth.enable = true;
        bluetooth.powerOnBoot = true;
      };

      networking.firewall.enable = false;
      programs.appimage.enable = false;
      programs.appimage.binfmt = false;

      services.xserver.videoDrivers = [ "nvidia" ];

      # persistance.cache.directories = [
      #   ".config/obs-studio"
      # ];

      # no conflicts
      # networking.networkmanager.unmanaged = [ "wlp15s0" ];
      # # speed
      # networking.firewall.allowedUDPPorts = [
      #   53
      #   67
      # ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      system.stateVersion = "25.11";
    };
}
