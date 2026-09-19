{
  delib,
  inputs,
  ...
}:
delib.module {
  name = "disko";

  options.disko = with delib; {
    enable = boolOption true;
    device = noDefault (strOption null);
  };

  nixos.always.imports = [ inputs.disko.nixosModules.disko ];

  nixos.ifEnabled = { cfg, ... }: {
    disko.devices = {
      disk.main = {
        type = "disk";
        device = cfg.device;
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "fmask=0022"
                  "dmask=0022"
                ];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
