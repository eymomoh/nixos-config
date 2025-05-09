{ config, pkgs, ... }:

let
  # Load your custom config file from disk
  myHyprconf = builtins.readFile ./myHyprconf.conf;
in {
  home.packages = with pkgs; [
    hyprland
  ];

  xdg.enable = true;

  # Map it to ~/.config/hypr/hyprland.conf
  xdg.configFile."hypr/hyprland.conf".text = myHyprconf;
}
