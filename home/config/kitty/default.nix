{
  programs.kitty = {
    enable = true;
    font.name = "JetBrainsMonoNF";
    font.size = 9;
    shellIntegration.enableBashIntegration = true;
    settings = {
      dynamic_background_opacity = true;
      confirm_os_window_close = 0;
      window_padding_width = 5;
      enable_audio_bell = false;
      background_opacity = "0.66";
      bold_font = "auto";
    };
    keybindings = {
      "ctrl+1" = "goto_tab 1";
      "ctrl+2" = "goto_tab 2";
      "ctrl+3" = "goto_tab 3";
      "ctrl+4" = "goto_tab 4";
      "ctrl+5" = "goto_tab 5";
      "ctrl+6" = "goto_tab 6";
      "ctrl+7" = "goto_tab 7";
      "ctrl+8" = "goto_tab 8";
      "ctrl+9" = "goto_tab 9";
    };
  };
}
