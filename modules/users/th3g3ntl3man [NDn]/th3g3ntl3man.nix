{
  self,
  lib,
  ...
}:
{
  flake.modules = lib.mkMerge [
    (self.factory.user "th3g3ntl3man" true)
    {
      nixos.th3g3ntl3man = {
        imports = with self.modules.nixos; [
          # developmentEnvironment
        ];
        users.users.th3g3ntl3man = {
          group = "audio";
        };
      };

      darwin.th3g3ntl3man = {
        imports = with self.modules.darwin; [
          # drawingApps
          # developmentEnvironment
        ];
      };

      homeManager.th3g3ntl3man =
        { pkgs, ... }:
        {
          imports = with self.modules.homeManager; [
            system-desktop
            # adminTools
            # vscode
            # passwordManager
          ];
          home.packages = with pkgs; [
            mediainfo
          ];
        };
    }
  ];
}
