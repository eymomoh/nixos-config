{ config, pkgs, ... }@args:

{
  imports = [
    # Add more module imports here
    ./myPkgs.nix
    ./myVars.nix
    ./myModules/hypr/myHyprland.nix
    ];

  home = {
    username = config.user;
    homeDirectory = config.homeDirectory;
    stateVersion = config.homeStateVersion;
	};



  programs = {
    home-manager = {
      enable = true;
          };
    git = {
      enable = true;
      userName = config.gitUsername;
      userEmail = config.gitEmail;
      aliases = {
	st = "status";
	a = "add";
	c = "commit -m";
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
	nix-r = "sudo nixos-rebuild switch --flake /etc/nixos"; #TODO make this reusable
	sy = "sudo yazi";
      };
      bashrcExtra = '' 
	eval "$(starship init bash)"

      ''; # bashrcExtra adds to bashrc file
    };


    }; # 'programs' end





} # module end
