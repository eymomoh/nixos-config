# *.nix
{ inputs, ... }:
{
  imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];

  programs.hyprpanel = {

    # Enable the module.
    # Default: false
    enable = true;
    overlay.enable = true;

     };
}
