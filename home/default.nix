{ config, pkgs, ... }@args:

{
  imports = [
    # Add more module imports here
    ./packages.nix
    ./variables.nix

    ];

  home = {
    username = "${mySettings.user}";
    homeDirectory = "${homeDirectory}";
    stateVersion = "${homeStateVersion}";
	};

  programs = {
    home-manager = {
      enable = true;
    };
    git = {
      enable = true;
      userName = "${gitUsername}";
      userEmail = "${gitEmail}";
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
