{ delib, lib, ... }:
delib.module {
  name = "programs.kitty";

  options = delib.singleEnableOption false;

  home.ifEnabled.programs.kitty = {
    enable = true;
    settings = {
      # font_family = "Fantasque SansM Nerd Font";
      font_size = 13;
      # wheel_scroll_min_lines = 1;
      # window_padding_width = 4;
      # confirm_os_window_close = 0;
      # scrollback_lines = 10000;
      # enable_audio_bell = false;
      # mouse_hide_wait = 60;
      # cursor_trail = 1;
      # tab_fade = 1;
      # active_tab_font_style = "bold";
      # inactive_tab_font_style = "bold";
      # tab_bar_edge = "top";
      # tab_bar_margin_width = 0;
      # tab_bar_style = "powerline";
      #tab_bar_style = "fade";
      # enabled_layouts = "splits";
      open_url_with_default = true;
      detect_urls = true;
      allow_remote_control = true;
    };

    shellIntegration.enableZshIntegration = true;
    shellIntegration.enableFishIntegration = true;
    shellIntegration.enableBashIntegration = true;
    shellIntegration.mode = "enabled";

    extraConfig = ''

      #open_url_with default
      url_prefixes file ftp ftps gemini git gopher http https irc ircs kitty sftp ssh
      #detect_urls yes

        # Clipboard
        map ctrl+shift+v        paste_from_selection
        map shift+insert        paste_from_selection

        #Manually set color scheme to catpuccin-mocha
        #Disabled stylix support

        ## name:     Catppuccin Kitty Mocha
        ## author:   Catppuccin Org
        ## license:  MIT
        ## upstream: https://github.com/catppuccin/kitty/blob/main/themes/mocha.conf
        ## blurb:    Soothing pastel theme for the high-spirited!

        # The basic colors
        foreground              #cdd6f4
        background              #1e1e2e
        selection_foreground    #1e1e2e
        selection_background    #f5e0dc

        # Cursor colors
        cursor                  #f5e0dc
        cursor_text_color       #1e1e2e

        # URL underline color when hovering with mouse
        url_color               #f5e0dc

        # Kitty window border colors
        active_border_color     #b4befe
        inactive_border_color   #6c7086
        bell_border_color       #f9e2af

        # OS Window titlebar colors
        wayland_titlebar_color system
        macos_titlebar_color system

        # Tab bar colors
        active_tab_foreground   #11111b
        active_tab_background   #cba6f7
        inactive_tab_foreground #cdd6f4
        inactive_tab_background #181825
        tab_bar_background      #11111b

        # Colors for marks (marked text in the terminal)
        mark1_foreground #1e1e2e
        mark1_background #b4befe
        mark2_foreground #1e1e2e
        mark2_background #cba6f7
        mark3_foreground #1e1e2e
        mark3_background #74c7ec

        # The 16 terminal colors

        # black
        color0 #45475a
        color8 #585b70

        # red
        color1 #f38ba8
        color9 #f38ba8

        # green
        color2  #a6e3a1
        color10 #a6e3a1

        # yellow
        color3  #f9e2af
        color11 #f9e2af

        # blue
        color4  #89b4fa
        color12 #89b4fa

        # magenta
        color5  #f5c2e7
        color13 #f5c2e7

        # cyan
        color6  #94e2d5
        color14 #94e2d5

        # white
        color7  #bac2de
        color15 #a6adc8


    '';
  };
}
