{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      ll = "ls -alh";
      ".." = "cd ..";
      cat = "bat";
      zq = "zoxide query";
      zqi = "zoxide query -i";
      za = "zoxide add";
      zr = "zoxide remove";
    };
  };
  home.file.bash.source = ~/.local/src/mybash/.bashrc;
}
