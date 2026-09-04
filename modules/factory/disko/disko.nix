{
  config.flake.factory.disko =
    {
      device,
      swapSize,
    }:
    {
      config,
      lib,
      ...
    }:
    {

      disko.devices = {
        disk = {
          main = {
            type = "disk";
            device = device;
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
              }

              // (
                if swapSize == null then
                  { }
                else
                  {
                    swap = {
                      size = swapSize;
                      content = {
                        type = "swap";
                      };
                    };
                  }
              );
            };
          };
        };
      };
    };
}
