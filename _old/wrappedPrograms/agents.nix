{
  self,
  lib,
  ...
}:
{
  flake.lib.agentHome =
    pkgs:
    {
      var,
      dir,
      instructions,
    }:
    let
      home = "$HOME/.local/share/${dir}";
      shared = "$HOME/.config/vjenv/AGENTS.md";
    in
    ''
      export ${var}="${home}"
      ${pkgs.coreutils}/bin/mkdir -p "${home}"
      if [ -f "${shared}" ]; then
        ${pkgs.coreutils}/bin/cp -f "${shared}" "${home}/${instructions}"
      fi
    '';

  flake.wrappers.gh =
    {
      wlib,
      pkgs,
      ...
    }:
    {
      imports = [ wlib.modules.default ];
      package = pkgs.gh;
      runShell = [ (self.lib.vjenv.gated pkgs "gh") ];
    };

}
