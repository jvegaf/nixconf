{ delib, pkgs, ... }:
delib.module {
  name = "programs.gh";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.shellAliases = {
      grc = "gh repo clone";
    };

    programs.gh = {
      enable = true;
      gitCredentialHelper.enable = true;
      extensions = with pkgs; [
        gh-s
      ];
    };
  };
}
