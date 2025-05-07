{ config, lib, ... }:

let
  # Define your variables here
  userSettings = {
    user = "eyanm"; # set your user's name
    host = "nixos"; # set your system hostname
    gitUserName = "eyanm"; # set your git username
    gitUserEmail = "enmomoh@gmail.com"; # set your git email
    homeDirectory = "/home/eyanm"; # set your home directory
    homeStateVersion = "24.11"; # the version of nixOS at the time home-manager was first written
  };

in {
  options = {
    user = lib.mkOption {
      type = lib.types.str;
      default = userSettings.user;
      description = "Username";
    };
    
    host = lib.mkOption {
      type = lib.types.str;
      default = userSettings.host;
      description = "Hostname";
    };

    gitUserName = lib.mkOption {
      type = lib.types.str;
      default = userSettings.gitUserName;
    };

    gitUserEmail = lib.mkOption {
      type = lib.types.str;
      default = userSettings.gitUserEmail;
    };

    homeDirectory = lib.mkOption {
      type = lib.types.str;
      default = userSettings.homeDirectory;
    };
  };

  config = userSettings;
}
