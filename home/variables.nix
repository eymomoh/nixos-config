{ config, lib, ... }:
{
let
  # Define your variables here
  userSettings = {
    user = "eyanm"; # set your user's name
    host = "nixos"; # set your system hostname
    gitUsername = "eyanm"; # set your git username
    gitEmail = "enmomoh@gmail.com"; # set your git email
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

    gitUsername = lib.mkOption {
      type = lib.types.str;
      default = userSettings.gitUserame;
    };

    gitEmail = lib.mkOption {
      type = lib.types.str;
      default = userSettings.gitEmail;
    };

    homeDirectory = lib.mkOption {
      type = lib.types.str;
      default = userSettings.homeDirectory;
    };

    homeStateVersion = lib.mkOption {
	type = lib.types.str;
	default = userSettings.homeStateVersion;
    };
  };

  mySettings = userSettings;
};
}
