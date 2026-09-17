{ delib, ... }:
delib.module {
  name = "constants";

  options.constants = with delib; {
    username = readOnly (strOption "th3g3ntl3man");
    userfullname = readOnly (strOption "Jose Vega");
    useremail = readOnly (strOption "josevega234@gmail.com");
    user = strOption "th3g3ntl3man";
    hostname = strOption "nixos-host";
    mainLocale = strOption "en_US.UTF-8";
    lcTime = strOption "";

    homeStateVersion = strOption "26.05";

    browser = strOption "firefox";
    fileManager = strOption "nautilus";

    # Apps that need to be launched inside a terminal (used by smartLaunch helpers)
    terminalApps = listOfOption lib.types.str [
      "nvim"
      "neovim"
      "vim"
      "hx"
      "helix"
      "yazi"
      "ranger"
      "lf"
      "btop"
      "nvtop"
    ];

    hyprland = {
      rounding = intOption 10;
      gap = intOption 5;
      borderSize = intOption 2;
      terminalOpacity = floatOption 1.0;
    };

    niri = {
      gap = intOption 8;
      rounding = intOption 10;
    };

    theme.catppuccin = {
      enable = true;
    };

    screenshots = strOption "$HOME/Pictures/Screenshots";
    keyboardLayout = strOption "us";
    keyboardVariant = strOption "";

    weather = strOption "Madrid";
    useFahrenheit = boolOption false;
    timeZone = strOption "Europe/Madrid";
  };
}
