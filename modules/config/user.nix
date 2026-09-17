{ delib, ... }:
delib.module {
  name = "user";

  # If you're not using NixOS, you can remove this entire block.
  nixos.always =
    { myconfig, ... }:
    let
      inherit (myconfig.constants) username;
    in
    {
      users = {
        groups.${username} = { };

        users.${username} = {
          isNormalUser = true;
          initialPassword = username;
          extraGroups = [ "wheel" ];
        };
      };
    };

}
