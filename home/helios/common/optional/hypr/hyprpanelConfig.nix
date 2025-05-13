{
  programs.hyprpanel = {
    enable = true;
    settings = {
      bar = {
        height = 32;
        position = "top";
        "modules-left" = [ "workspaces" ];
        "modules-center" = [ "clock" ];
        "modules-right" = [ "tray" "battery" "network" ];
      };

      clock = {
        format = "%H:%M";
        tooltip = "%A, %d %B %Y";
      };

      battery = {
        "show-percentage" = true;
      };
    };
  };
}

