{ config, pkgs, ... }@args:

{
  imports = [
    # Add more module imports here
    ./myPkgs.nix
    ./heliosVars.nix
    ./common/optional/hypr/myHyprland.nix
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
	aa = "add .";
	# add other aliases here
	};
      extraConfig = {
      	init.defaultBranch = "main";
	color.ui = true;
	};
      };
    bash = {
      enable = true;
      # completion.enable = true; <- doesnt work but i want it to :-)
      shellAliases = {
	nix-r = "sudo nixos-rebuild switch --flake /etc/nixos"; #TODO make this reusable
	sy = "sudo yazi";
	ff = "fastfetch";
	nixos = "cd /etc/nixos"; # nix config path
	cfg = "cd ${config.homeDirectory}/.config"; #.config path
	initExtra = ''
	  fastfetch
	  wal -i /home/eyanm/Pictures/Wallpapers/wall1.jpg
	'';
      };
      bashrcExtra = '' 
	eval "$(starship init bash)"

      ''; # bashrcExtra adds to bashrc file
    };


    }; # 'programs' end





} # module end
