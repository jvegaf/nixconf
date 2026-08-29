{
  lib,
  inputs,
  self,
  ...
}:
{
  flake.wrappers.environment =
    { pkgs, ... }:
    let
      selfpkgs = self.packages."${pkgs.stdenv.hostPlatform.system}";

      packageOf = entry: entry.data or entry;

      runtimeTools = [
        pkgs.nil
        pkgs.nixd
        pkgs.statix
        pkgs.alejandra
        pkgs.manix
        pkgs.nix-inspect
        pkgs.file
        pkgs.unzip
        pkgs.zip
        pkgs.p7zip
        pkgs.wget
        pkgs.killall
        pkgs.sshfs
        pkgs.fzf
        pkgs.htop
        selfpkgs.btop
        pkgs.eza
        pkgs.fd
        pkgs.zoxide
        pkgs.dust
        pkgs.ripgrep
        pkgs.fastfetch
        pkgs.tree-sitter
        pkgs.imagemagick
        pkgs.imv
        pkgs.quickshell
        pkgs.ffmpeg
        pkgs.yt-dlp
        pkgs.lazygit
        pkgs.just
        pkgs.mprocs
        pkgs.yazi
        pkgs.zsh-syntax-highlighting
        pkgs.zsh-autosuggestions
        # pkgs.devenv
        selfpkgs.nh
        selfpkgs.vjenv
        # selfpkgs.neovimDynamic
        selfpkgs.qalc
        selfpkgs.git
        selfpkgs.zsh
        selfpkgs.nix-check-bin
      ];
    in
    {
      imports = [ self.wrapperModules.zsh ];
      binName = "zsh";
      runtimePkgs = runtimeTools;

      env = {
        # EDITOR = lib.getExe selfpkgs.neovimDynamic;
        __NIXOS_SET_ENVIRONMENT_DONE = "1";

        FZF_DEFAULT_OPTS =
          with self.theme;
          lib.concatStringsSep " " [
            "--color=bg+:${base01},bg:${base00},spinner:${base0C},hl:${base0D}"
            "--color=fg:${base04},header:${base0D},info:${base0A},pointer:${base0C}"
            "--color=marker:${base0C},fg+:${base06},prompt:${base0A},hl+:${base0D}"
            "--color=border:${base02},gutter:${base00},query:${base06}"
          ];
      };
    };

  flake.wrappers.terminal =
    { pkgs, ... }:
    let
      selfpkgs = self.packages."${pkgs.stdenv.hostPlatform.system}";
    in
    {
      imports = [ self.wrapperModules.kitty ];
      shell = lib.getExe selfpkgs.environment;
    };

  perSystem = { pkgs, ... }: {
    packages.screenshot = pkgs.writeShellApplication {
      name = "screenshot";
      text = "${pkgs.grim}/bin/grim -l 0 - | ${pkgs.wl-clipboard}/bin/wl-copy ";
    };

    packages.screenshotFull = pkgs.writeShellApplication {
      name = "screenshotFull";
      text = ''${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp -w 0)" - | ${pkgs.wl-clipboard}/bin/wl-copy'';
    };

    packages.pipeSwappy = pkgs.writeShellApplication {
      name = "pipeSwappy";
      text = "${pkgs.wl-clipboard}/bin/wl-paste | ${pkgs.swappy}/bin/swappy -f -";
    };

    packages.nix-check-bin = pkgs.writeShellScriptBin "nix-check-bin" ''
      $EDITOR "$(nix build "$1" --no-link --print-out-paths)/bin"
    '';

    # packages.dev = pkgs.writeTextFile {
    #   name = "dev";
    #   executable = true;
    #   destination = "/bin/dev";
    #   text = let
    #     vjenv = "${self.packages.${pkgs.stdenv.hostPlatform.system}.vjenv}/bin/vjenv";
    #   in ''
    #     #!${lib.getExe pkgs.fish}
    #     if set -q argv[1]
    #         set -l override (${vjenv} use --shell fish $argv[1]); or exit 1
    #         echo $override | source
    #     end
    #     ${vjenv} env fish --no-devshell | source
    #     set -gx NIXPKGS_ALLOW_UNFREE 1
    #     nix develop --impure -c $SHELL
    #   '';
    # };
  };
}
