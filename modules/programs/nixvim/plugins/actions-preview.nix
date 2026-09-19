{ delib, ... }:
delib.module {
  # collection of plugins
  name = "programs.nixvim.plugins.actions-preview";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.nixvim = {
    keymaps = [
      {
        mode = "n";
        key = "<leader>ca";
        action.__raw = ''
          function() require("actions-preview").code_actions() end
        '';
        options.desc = "Code Actions";
      }
    ];
    plugins = {
      actions-preview = {
        enable = true;
        settings = {
          backend = [
            "snacks"
            "telescope"
          ];
        };
      };
    };
  };
}
