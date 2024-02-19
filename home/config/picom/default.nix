{
  services.picom = {
    enable = true;
    backend = "glx";
    vSync = false;
    settings = {
      dbus = false;
      frame-opacity = "1.0";
      inactive-opacity-override = false;
      active-opacity = "1.0";
      inactive-opacity = "1.0";
      inactive-dim = 0.0;
      opacity-rule = [ 
        "100:class_g = 'firefox'"
      ];
      blur = {
        method = "dual_kawase";
	strength = "5.0";
	deviation = "1.0";
	kernel = "11x11gaussian";
      };
      blur-background = false;
      blur-background-frame = true;
      blur-background-fixed = true;
      mark-wmwin-focused = true;
      mark-ovredir-focused = true;
      detect-rounded-corners = true;
      detect-client-opacity = true;
      detect-transient = true;
      detect-client-leader = true;
      resize-damage = 1;
      glx-no-stencil = true;
      use-damage = true;
      transparent-clipping = false;
      show-all-xerrors = true;


    };
    wintypes = {
      dock = { shadow = false; };
      dnd = { shadow = false; };
      tooltip = { shadow = false; };
      menu = { opacity = false; };
      dropdown_menu = { opacity = false; };
      popup_menu = { opacity = false; };
      utility = { opacity = false; };
    };
  };
}
