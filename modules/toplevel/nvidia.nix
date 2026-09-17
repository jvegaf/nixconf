{
  delib,
  config,
  pkgs,
  ...
}:
delib.module {
  name = "hardware.gpu.nvidia";

  options.hardware.gpu.nvidia = with delib; {
    enable = boolOption false;
    open = boolOption false;
    primeSync = boolOption false;
    kernelPackage = enumOption [
      "legacy"
      "latest"
      "stable"
    ] "stable";
  };

  nixos.ifEnabled =
    { cfg, ... }:
    {
      boot.initrd.availableKernelModules = [
        "nvidia"
      ];

      hardware.nvidia = {
        open = cfg.open;
        nvidiaPersistenced = true;
        package =
          if cfg.kernelPackage == "legacy" then
            config.boot.kernelPackages.nvidiaPackages.legacy_580
          else if cfg.kernelPackage == "latest" then
            config.boot.kernelPackages.nvidiaPackages.latest
          else
            config.boot.kernelPackages.nvidiaPackages.stable;

        powerManagement.enable = true;
        modesetting.enable = true;
        nvidiaSettings = true;
        prime = {
          sync.enable = cfg.primeSync;
          offload.enable = !cfg.primeSync;
          intelBusId = "PCI:0:2:0";
          nvidiaBusId = "PCI:1:0:0";
        };
      };

      services.xserver.videoDrivers = [ "nvidia" ];

      environment.systemPackages = with pkgs; [
        nvtopPackages.full # Monitor de GPU

        mesa-demos # Info OpenGL (glxinfo)
        # Utilidades sistema
        lm_sensors # Sensores de temperatura
      ];
    };
}
