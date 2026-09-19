{
  delib,
  pkgs,
  inputs,
  lib,
  ...
}:
delib.module {
  name = "kernel";
  nixos.always = { myconfig, ... }: {
    boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
  };
}
