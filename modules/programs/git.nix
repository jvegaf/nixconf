{ delib, ... }:
delib.module {
  # version control system
  name = "programs.git";

  options = delib.singleEnableOption false;

  home.ifEnabled = { myconfig, ... }: {
    programs.git = {
      enable = true;
      ignores = [
        "node_modules"
      ];
      settings = {
        init.defaultBranch = "main";
        push = {
          autoSetupRemote = true;
          default = "simple";
        };
        user = {
          email = myconfig.constants.gitEmail;
          name = myconfig.constants.gitUser;
        };
      };
    };

    home = {
      shellAliases = {
        ga = "git add";
        gaa = "git add .";
        gc = "git commit";
        gca = "git commit --amend";
        gcl = "git clone";
        gcm = "git commit -m";
        gco = "git checkout";
        gcp = "git cherry-pick";
        gd = "git diff";
        gdc = "git diff --cached";
        glg = "git log --stat";
        gpl = "git pull --rebase";
        gpo = "git push origin \"$(git symbolic-ref --short HEAD)\"";
        grh = "git reset HEAD";
        grm = "git rm";
        gs = "git status";
      };
    };
  };
}
