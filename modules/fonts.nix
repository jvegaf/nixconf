{ delib, pkgs, ... }:
delib.module {
  name = "fonts";

  nixos.always.fonts.fontconfig.enable = true;
  nixos.always.fonts.packages = with pkgs; [
    dejavu_fonts
    liberation_ttf
    noto-fonts
    nerd-fonts.zed-mono
    nerd-fonts.victor-mono
    nerd-fonts.fantasque-sans-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    open-sans
    noto-fonts
    liberation_ttf_v2
    dejavu_fonts
    cantarell-fonts
  ];
}
