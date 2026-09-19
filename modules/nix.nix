{ delib, ... }:
delib.module {
  name = "nix";

  nixos.always = {
    nix = {
      settings = {
        trusted-users = [
          "root"
          "th3g3ntl3man"
        ];
        substituters = [
          "https://nix-community.cachix.org"
          "https://niri.cachix.org"
          "https://cache.nixos.org"
          "https://cache.numtide.com"
        ];
        trusted-substituters = [
          "https://nix-community.cachix.org"
          "https://niri.cachix.org"
          "https://cache.nixos.org"
          "https://cache.numtide.com"
        ];
        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
        ];
        auto-optimise-store = true;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
      };
      gc = {
        automatic = true;
        dates = "weekly";
      };
    };

    programs.nix-ld.enable = true;
    programs.zsh.enable = true;
  };
}
