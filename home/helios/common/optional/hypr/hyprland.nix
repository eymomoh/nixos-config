{ config, pkgs, ... }:

let
  # Load your custom config file from disk
  hyprconf = builtins.readFile ./hyprconf.conf;
in {
  home.packages = with pkgs; [
    hyprland
  ];

  xdg.enable = true;

  # Map it to ~/.config/hypr/hyprland.conf
  xdg.configFile."hypr/hyprland.conf".text = hyprconf;
}
