# *.nix
{ config, pkgs, ... }:

let
  # Load your custom config file from disk
  hyprpanelConf = builtins.readFile ./hyprpanelConf.conf;
in {
  home.packages = with pkgs; [
    hyprpanel
  ];

  xdg.enable = true;

  # Map it to ~/.config/hypr/hyprland.conf
  xdg.configFile."hyprpanel/config.json".text = hyprpanelConf;
}
