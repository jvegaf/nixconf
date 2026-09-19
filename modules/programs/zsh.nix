{
  delib,
  homeConfig,
  pkgs,
  ...
}:
delib.module {
  # shell
  name = "programs.zsh";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    programs = {
      zsh = {
        enable = true;
        # move config files from home to the standard config location
        dotDir = "${homeConfig.xdg.configHome}/zsh";
        # auto complete ghost text
        autosuggestion.enable = true;
        fastSyntaxHighlighting.enable = true;
        prezto = {
          enable = true;
          pmodules = [
            "completion" # auto completion
            "directory" # auto pushd/popd
            "editor" # emacs key bindings
            "history" # history setup
          ];
        };
        initContent = ''
          # Start Tmux automatically if not already running. No Tmux in TTY
          # if [ -z "$TMUX" ] && [ -n "$DISPLAY" ]; then
          #   tmux attach-session -t default || tmux new-session -s default
          # fi

          # fastfetch

          # Start UWSM
          # if uwsm check may-start > /dev/null && uwsm select; then
          #   exec systemd-cat -t uwsm_start uwsm start default
          # fi
        '';
      };
    };

    home = {
      shellAliases = {
        md = "mkdir -p";
      };
    };
  };

  nixos.ifEnabled = {
    users.defaultUserShell = pkgs.zsh;

    programs.zsh.enable = true;
  };
}
