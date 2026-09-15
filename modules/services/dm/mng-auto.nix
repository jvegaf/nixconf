{
  delib,
  ...
}:
delib.module {
  name = "services.displayManager.autoLogin";

  options.services.displayManager.autoLogin = with delib; {
    enable = boolOption false;
    username = strOption "foo";
    defaultSession = strOption "mango";
  };

  nixos.ifEnabled = { cfg, ... }: {
    services.displayManager = {
      defaultSession = cfg.defaultSession; # derived from mango.desktop filename
      autoLogin = {
        enable = true;
        user = cfg.username;
      };
    };

  };
}
