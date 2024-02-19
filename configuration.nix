# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  documentation.nixos.enable = false;	

  nix = {
    package = pkgs.nixUnstable;
    settings = {
    warn-dirty = false;
    experimental-features = "nix-command flakes auto-allocate-uids configurable-impure-env";
    auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = ["nohibernate"];
    tmp.cleanOnBoot = true;
    supportedFilesystems = ["ntfs"];
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 300;
      grub = {
        device = "nodev";
	efiSupport = true;
	enable = true;
	timeoutStyle = "menu";
      };
    };	
		
    kernelModules = ["tcp_bbr"];
    kernel.sysctl = {
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.core.default_qdisc" = "fq";
      "net.core.wmem_max" = 1073741824;	
      "net.core.rmem_max" = 1073741824;	
      "net.ipv4.tcp_rmem" = "4096 87380 1073741824";
      "net.ipv4.tcp_wmem" = "4096 87380 1073741824";
    };
  };
 	
  networking = {
    hostName = "main";
    networkmanager.enable = true;
    enableIPv6 = false;
    firewall.enable = false;
  }; 

  time.timeZone = "Africa/Cairo";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };
  console = {
    packages = [pkgs.terminus_font];
    font = "${pkgs.terminus_font}/share/consolefonts/ter-i22b.psf.gz";
    useXkbConfig = true;
  };
	
  services = {
    dbus.enable = true;
    jellyfin.enable = true;
    gvfs.enable = true;

    xserver = {
      enable = true;
      windowManager.dwm.enable = true;
      xkb.layout = "us";
      videoDrivers = ["amdgpu" "ati"];
      deviceSection = ''
        Option "TearFree" "on"
	'';

      displayManager = {
         lightdm.enable = true;
	 autoLogin = {
	       enable = true;
	       user = "user";
	 };
      };
    };
      pipewire = {
          enable = true;
	  alsa.enable = true;
	  alsa.support32Bit = true;
	  pulse.enable = true;
	  jack.enable = true;
      };
  };
	
  hardware.opengl = {
      enable = true;
      extraPackages = with pkgs; [
          vaapiVdpau
	  libvdpau-va-gl
      ];
  };


  nixpkgs.overlays = [
      (final: prev: {
          dwm = prev.dwm.overrideAttrs (old: {src = /home/user/.local/src/suckless/dwm;});
      })
      (final: prev: {
	  dmenu = prev.dmenu.overrideAttrs (old: {src = /home/user/.local/src/suckless/dmenu;});
      })
      (final: prev: {
	  st = prev.st.overrideAttrs (old: {src = /home/user/.local/src/suckless/st;});
      })
  ];

  sound = {
      enable = true;
      extraConfig = ''
          defaults.pcm.!card 1
	  defaults.ctl.!card 1 '';
  };

  programs.java.enable = true;

  users.users.user= {
      isNormalUser = true;
      description = "Khalifa";
      extraGroups = [
          "disk"
	  "sshd"
	  "sudo"
	  "networkmanager"
	  "wheel"	
	  "audio"
	  "video"
	  "root"
      ];
  };

  fonts = {
      packages = with pkgs; [
	  nerdfonts
          noto-fonts
	  noto-fonts-cjk
	  noto-fonts-emoji
	  font-awesome
	  source-han-sans
	  source-han-sans-japanese
	  source-han-serif-japanese
	  (nerdfonts.override {fonts = ["JetBrainsMono"];})		
      ];
      fontconfig = {
          enable = true;
	  defaultFonts = {
	      monospace = ["JetBrainsMonoNF" "NotoSansArabic" "NotoColorEmoji" "NotoSansCJK-VF" ];
	      serif = ["NotoSerif" "SourceHanSerif" "NotoSansArabic" "NotoColorEmoji" "JetBrainsMonoNF" "Noto SansCJK-VF" ];
	      sansSerif = ["NotoSans" "SourceHanSans" "NotoSansArabic" "NotoColorEmoji" "JetBrainsMonoNF" "NotoSansCJK-VF" ];
	  };
      };
  };

  security = {
      polkit.enable = true;
      rtkit.enable = true;

      sudo = {
          extraRules = [
	      { users = [ "user" ];
	  	commands = [
		    { command = "ALL" ;
		        options = [ "NOPASSWD" ];
		    }
		];
	      }
	  ];
       };
  };

  environment = {
    etc = {
            "pipewire/pipewire.conf.d/92-low-latency.conf".text = ''
	        context.properties = {
		    default.clock.rate = 48000
		    default.clock.quantum = 32
		    default.clock.min-quantum = 32
		    default.clock.max-quantum = 32 }
	     '';
      };
    systemPackages = with pkgs; [
      alsa-utils
      alsa-plugins
      android-tools
      alsa-firmware
      jre_minimal
      vim 
      mesa
      mpv
      libdrm
      wget
      gammastep
      gh
      gnupg
      glxinfo
      dmenu 
      st
      ntfs3g
      linuxKernel.packages.linux_6_1.cpupower
      pamixer
      neovim
      firefox
      git
      gnumake
      htop
      clang-tools_9
      dunst
      efibootmgr
      fontconfig
      freetype
      ffmpeg
      fuse-common
      gcc
      grub2
      kitty
      openssl
      terminus-nerdfont
      vscode-with-extensions
      webkitgtk_6_0
      xclip
      xdg-desktop-portal-gtk
      zoxide
      ];
  };

  xdg.portal = {
      enable = true;
      config.common.default = "gtk";
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };
  
  systemd = {
      user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];

          serviceConfig = {
	      Type = "simple";
	      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
	      Restart = "on-failure";
	      RestartSec = 1;
	      TimeoutStopSec = 10;
	  };
      };
  };

  system.stateVersion = "23.11"; 
}
