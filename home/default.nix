{ config, pkgs, ... }@args:

{
  imports = [
    # Add more module imports here
    ./variables.nix
    ./packages.nix

    ];

  home = {
    username = "${config.user}";
    homeDirectory = ${config.homeDirectory};
    stateVersion = "${config.homeStateVersion}";
	};

  programs = {
    git = {
      enable = true;
      userName = "${config.gitUserName}";
      userEmail = "${config.gitUserEmail}";
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
	nix-update = "sudo nixos-rebuild switch --flake ./etc/nixos" #TODO make this reusable
      };
    };


    }; # 'programs' end





} # module end
