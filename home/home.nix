{ pkgs, ... }: 
let
  username = "user";
in {
  imports = [
    ./config
  ];

  fonts.fontconfig.enable = true;

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };


  home = {
  	username = "${username}";
	homeDirectory = "/home/${username}";
	stateVersion = "23.11";
	enableNixpkgsReleaseCheck = false;

	packages = with pkgs; [
	  anki
	  unzip
	  bat
	  ticktick
	  nordic
	  jmtpfs
	  papirus-nord
	  discord
	  simp1e-cursors
	  lxappearance
	  whatsapp-for-linux
	  breeze-icons
	  pulseaudio
	  feh
	  flameshot
	  jellyfin
	  jellyfin-web
	  jellyfin-media-player
	  gnome.gnome-keyring
	  picom
	  pavucontrol
	  polkit_gnome
	  zoxide
	];

  	sessionVariables = {
	     EDITOR = "nvim";
	     BROWSER = "firefox";
  	};
  };

  programs.home-manager.enable = true;

}
