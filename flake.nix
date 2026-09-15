{
  description = "Modular configuration of NixOS, Home Manager, and Nix-Darwin with Denix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    denix = {
      url = "github:yunfachi/denix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    yazi.url = "github:sxyazi/yazi";
    hardware.url = "github:NixOS/nixos-hardware/master";
    flake-parts.url = "github:hercules-ci/flake-parts";
    stylix.url = "github:nix-community/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    mangowm.url = "github:mangowm/mango";
    mangowm.inputs.nixpkgs.follows = "nixpkgs";
    voxtype.url = "github:peteonrails/voxtype";
    vicinae.url = "github:vicinaehq/vicinae";
    vicinae-extensions = {
      url = "github:vicinaehq/extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms-plugin-registry = {
      url = "github:AvengeMedia/dms-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.flake-parts.follows = "flake-parts";
    razerdaemon.url = "github:encomjp/razer-control-revived";
    razerdaemon.inputs.nixpkgs.follows = "nixpkgs";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    llm-agents.url = "github:numtide/llm-agents.nix";

    superpowers = {
      url = "github:obra/superpowers";
      flake = false;
    };
  };

  outputs =
    { denix, ... }@inputs:
    let
      mkConfigurations =
        moduleSystem:
        denix.lib.configurations {
          inherit moduleSystem;
          homeManagerUser = "th3g3ntl3man";

          paths = [
            ./hosts
            ./modules
            ./rices
          ];

          extensions = with denix.lib.extensions; [
            args
            (base.withConfig {
              args.enable = true;
            })
          ];

          specialArgs = {
            inherit inputs;
          };
        };
    in
    {
      # If you're not using NixOS, Home Manager, or Nix-Darwin,
      # you can safely remove the corresponding lines below.
      nixosConfigurations = mkConfigurations "nixos";
      homeConfigurations = mkConfigurations "home";
    };
}
