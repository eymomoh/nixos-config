{ config, pkgs, ... }@args:

{
  imports = [
    # Add more module imports here
    ./myPkgs.nix
    ../../hosts/nixos/common/core/userVars.nix
    ./common/optional/hypr/hyprland.nix
    ./common/optional/hypr/hyprpanel.nix
    ./common/optional/sunshine.nix

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
	nr = "sudo nixos-rebuild switch --flake /etc/nixos"; #TODO make this reusable
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
	export VISUAL=neovim
	export EDITOR="$VISUAL"

      ''; # bashrcExtra adds to bashrc file
    };


    }; # 'programs' end





} # module end
