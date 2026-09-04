{
  inputs,
  ...
}:
{
  flake.homeConfigurations = inputs.self.lib.mkHomeManager "x86_64-linux" "th3g3ntl3man";
}
