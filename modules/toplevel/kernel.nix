{
  delib,
  pkgs,
  inputs,
  ...
}:
delib.module {
  name = "kernel";
  nixos.always = { myconfig, ... }: {
    boot.kernelPackages = pkgs.linuxPackages_latest;
  };
}
