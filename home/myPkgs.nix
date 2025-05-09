{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    pywal
    hyprpicker
    hyprsome
    pywalfox-native
     # Add more packages here
  ];
  
  # configure pywal here or pass args
  # programs.pywal {
     # enable = true;

   # };






}
