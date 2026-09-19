{
  delib,
  config,
  ...
}:
delib.module {
  name = "user";

  options =
    with delib;
    moduleOptions {
      defaultUserShell = allowPath (packageOption "/bin/sh");
    };

  nixos.always =
    { myconfig, cfg, ... }:
    let
      inherit (myconfig.constants) username;
    in
    {
      users = {
        inherit (cfg) defaultUserShell;
        groups.${username} = { };

        users.${username} = {
          isNormalUser = true;
          extraGroups = [
            "audio"
            "input"
            "uucp"
            "video"
            "networkmanager"
            "seat"
            "wheel"
          ];
        };
      };
    };
}
