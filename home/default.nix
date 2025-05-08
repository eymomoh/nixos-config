{ config, pkgs, mySettings, ... }@args:

{
  imports = [
    # Add more module imports here
    ./packages.nix

    ];

  home = {
    username = "${mySettings.user}";
    homeDirectory = "${mySettings.homeDirectory}";
    stateVersion = "${mySettings.homeStateVersion}";
	};

  programs = {
    home-manager = {
      enable = true;
    };
    git = {
      enable = true;
      userName = "${mySettings.gitUsername}";
      userEmail = "${mySettings.gitEmail}";
      aliases = {
	st = "status";
	# add other aliases here
	};
      extraConfig = {
      	init.defaultBranch = "main";
	color.ui = true;
	};
      };
    bash = {
      enable = true;
      shellAliases = {
	nix-update = "sudo nixos-rebuild switch --flake ./etc/nixos"; #TODO make this reusable
      };
    };


    }; # 'programs' end





} # module end
