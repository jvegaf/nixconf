{ delib, ... }:
delib.module {
  # remote server access
  name = "programs.ssh";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings."*" = {
        IdentityFile = "~/.ssh/id_ed25519";
        AddKeysToAgent = "yes";
      };
    };
  };
}
