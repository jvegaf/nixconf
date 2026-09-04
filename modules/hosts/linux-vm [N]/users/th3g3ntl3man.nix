{
  inputs,
  self,
  ...
}:
{
  flake.modules.nixos.linux-desktop =
    { config, ... }:
    {
      imports =
        with inputs.self.modules.nixos;
        with inputs.self.factory;
        [
          th3g3ntl3man
        ];

      # age.secrets."homeserver-cred" = {
      #   file = "${self.inputs.secrets}/homeserver-cred.age";
      # };

      # ...

      home-manager.users.th3g3ntl3man = {
        ###
      };
    };
}
