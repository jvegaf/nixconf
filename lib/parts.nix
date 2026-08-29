{
  inputs,
  lib,
  ...
}:
{
  imports = [
    inputs.wrapper-modules.flakeModules.wrappers
  ];

  options.flake.lib = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.raw;
    default = { };
    description = "Helpers shared between modules in this flake";
  };

  config = {
    perSystem = { system, ... }: {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          # (inputs.nixpkgs-multiverse.lib.pinOverlay {
          #   pins."godot-mono" = "4.6.3-stable";
          # })
        ];
      };
    };

    systems = [
      # "aarch64-darwin"
      # "aarch64-linux"
      # "x86_64-darwin"
      "x86_64-linux"
    ];
  };
}
