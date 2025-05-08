# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./nvidia.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = false;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # ADDED Enable Bluetooth (+ bluez pkg added in system packages)
  services.blueman.enable = true;

  # ADDED System shutdown after 10s
  systemd.extraConfig = ''
  DefaultTimeoutStopSec=10s
'';


  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.eyanm = {
    isNormalUser = true;
    description = "illest chiller ever";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };


  nix.settings.experimental-features = [ "nix-command" "flakes"];

 # Hyperland setup
  programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  programs.hyprland.xwayland.enable = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  
  # Install firefox.
  programs.firefox.enable = true;
 
  # ADDED enable bash auto-complete
  programs.bash.enableCompletion = true;

  # Allow unfree
  nixpkgs.config.allowUnfree = true;


  environment.systemPackages = with pkgs; [

   # terminal-like text editor
   neovim
   # terminal file manager
   yazi
   # terminal image viewer
   ueberzugpp
   # better terminal
   alacritty
   # even better term em
   ghostty
   # hardware config info
   lshw
   # fuzzy finder terminal
   fzf
   # git
   git
   lazygit
   # terminal prompt customization
   starship
   # unzip
   unzip


   # brightness control
   brightnessctl
  
   # obsidian notes
   obsidian
  
   # file manager
   xfce.thunar

   # neofetch alt
   fastfetch

   # bluetooth
   bluez
   blueman

  ###################
   # hyprland packages #
   # check hyprland wiki for more suggestions #
   ###################
  
   # hyprland
   hyprland

   # hyprland taskbar
   waybar

   # fonts & glyphs
   font-awesome

   # notification daemon
   swaynotificationcenter
   	libnotify
   	
   # app launcher
   wofi

   # wallpaper daemon
   hyprpaper

   # authentication agent
   hyprpolkitagent

   # screenshots
   hyprshot

   # lockscreen
   hyprlock

   # idle / watcher
   hypridle

   # gtk themes
   #whitesur-gtk-theme
   #atelier-heath-gtk-theme

   # cursor themes
   phinger-cursors



   ###################

 
  ];

  # FONTS GO HERE #
  fonts.packages = with pkgs; [
  	
	font-awesome
  	inter
	roboto-mono
	nerd-fonts.monoid
	jetbrains-mono
	nerd-fonts.jetbrains-mono
	];




  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
