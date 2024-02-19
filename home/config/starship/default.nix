{
  programs.starship = { 
    enable = true;
    enableBashIntegration = true;
  };
  home.file.starship.source = ~/.config/starship.toml;
}
