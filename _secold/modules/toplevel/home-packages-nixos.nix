{
  delib,
  pkgs,
  pkgs-unstable,
  lib,
  config,
  ...
}:
delib.module {
  name = "home-packages";
  options = delib.singleEnableOption true;

  nixos.ifEnabled =
    { myconfig, ... }:
    let
      # 🔄 TRANSLATION LAYER
      translatedEditor =
        let
          e = myconfig.constants.editor or "vscode";
        in
        if e == "nvim" then "neovim" else e;

      # 🛡️ SAFE FALLBACKS
      fallbackTerm = pkgs.kitty;
      fallbackBrowser = pkgs.firefox;
      fallbackFileManager = pkgs.nautilus;
      fallbackEditor = pkgs.neovim;

      # 🔍 PACKAGE LOOKUP
      getPkg =
        name: fallback:
        if builtins.hasAttr name pkgs then
          pkgs.${name}
        else if builtins.hasAttr name pkgs.kdePackages then
          pkgs.kdePackages.${name}
        else
          fallback;

      termName = myconfig.constants.terminal.name or "kitty";
      myTermPkg = getPkg termName fallbackTerm;

      browserName = myconfig.constants.browser or "firefox";
      myBrowserPkg = getPkg browserName fallbackBrowser;

      fileManagerName = myconfig.constants.fileManager or "nautilus";
      myFileManagerPkg = getPkg fileManagerName fallbackFileManager;

      editorName = translatedEditor;
      myEditorPkg = getPkg editorName fallbackEditor;
    in
    {

      environment.systemPackages =
        let
          isProgramEnabled =
            name:
            lib.attrByPath [ "programs" name "enable" ] false config
            || lib.attrByPath [
              "home-manager"
              "users"
              myconfig.constants.user
              "programs"
              name
              "enable"
            ] false config;
        in
        (lib.optional (!isProgramEnabled termName) myTermPkg)
        ++ (lib.optional (!isProgramEnabled browserName) myBrowserPkg)
        ++ (lib.optional (!isProgramEnabled fileManagerName) myFileManagerPkg)
        ++ (lib.optional (!isProgramEnabled editorName) myEditorPkg)
        ++ (with pkgs; [
          cliphist
        ])
        ++ (with pkgs.kdePackages; [
          gwenview
        ])
        ++ (with pkgs-unstable; [ ]);
    };

}
