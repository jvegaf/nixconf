{
  delib,
  inputs,
  pkgs,
  moduleSystem,
  ...
}:
let
  extraSubstituters = [
    "https://hyprland.cachix.org"
    "https://cosmic.cachix.org"
    "https://walker.cachix.org"
    "https://vicinae.cachix.org"
    "https://nix-community.cachix.org"
    "https://cache.numtide.com"
  ];
  extraTrustedPublicKeys = [
    "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
    "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
    "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
  ];
in
delib.module {
  name = "nix";

  home.always =
    if moduleSystem == "home" then
      {
        imports = [
          inputs.nix-index-database.homeModules.nix-index
        ];

        nix.package = pkgs.nix;
        nix.settings = {
          trusted-substituters = extraSubstituters;
          trusted-public-keys = extraTrustedPublicKeys;
        };
      }
    else
      {
        imports = [
          inputs.nix-index-database.homeModules.nix-index
        ];
      };

  nixos.always = { myconfig, ... }: {
    imports = [
      inputs.nix-index-database.nixosModules.nix-index
    ];

    nixpkgs.overlays = [
      inputs.nix-index-database.overlays.nix-index
      (final: prev: {
        openblas =
          if final.stdenv.hostPlatform.system == "i686-linux" then
            prev.openblas.overrideAttrs (_: {
              doCheck = false;
            })
          else
            prev.openblas;
      })
    ];

    nix.nixPath = [ "nixpkgs=flake:nixpkgs" ];

    nix.settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        "root"
        myconfig.constants.username
        "@wheel"
      ];
      auto-optimise-store = true;
      accept-flake-config = true;

      trusted-substituters = extraSubstituters;
      trusted-public-keys = extraTrustedPublicKeys;
    };
    nix.gc.automatic = false;
  };
}
