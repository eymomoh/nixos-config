{ config, lib, ... }:

let
  userSettings = {
    user = "helios";
    host = "sol";
    gitUsername = "eyanm";
    gitEmail = "enmomoh@gmail.com";
    homeDirectory = "/home/eyanm";
    homeStateVersion = "24.11";
  };
in
{
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
      default = userSettings.gitUsername;
      description = "Git username";
    };

    gitEmail = lib.mkOption {
      type = lib.types.str;
      default = userSettings.gitEmail;
      description = "Git email";
    };

    homeDirectory = lib.mkOption {
      type = lib.types.str;
      default = userSettings.homeDirectory;
      description = "Home directory path";
    };

    homeStateVersion = lib.mkOption {
      type = lib.types.str;
      default = userSettings.homeStateVersion;
      description = "Home Manager state version";
    };
  };

  config = userSettings;
}

