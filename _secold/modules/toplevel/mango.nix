{
  delib,
  inputs,
  lib,
  moduleSystem,
  ...
}:
delib.module {
  name = "programs.mango";
  options = delib.singleEnableOption false;

  nixos.always = { ... }: {
    imports = [
      inputs.mangowm.nixosModules.mango
    ];
    home-manager.sharedModules = [
      inputs.mangowm.hmModules.mango
    ];
  };

  home.always = { ... }: {
    imports = lib.optionals (moduleSystem == "home") [
      inputs.mangowm.hmModules.mango
    ];
  };

  nixos.ifEnabled = {
    programs.mango = {
      enable = true;
    };
  };
}
