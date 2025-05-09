{
  description = "My awesome main-flake!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
  
  let
    pkgs = nixpkgs.legacyPackages.${system};
    system = "x86_64-linux";
    # GLOBAL CONFIG VARIABLES
  #  mySettings = {
   #   system = "x86_64-linux"; # system architecture
   #   user = "eyanm"; # username
   #   host = "nixos"; # system hostname
   #   gitUsername = "eyanm";
   #   gitEmail = "enmomoh@gmail.com";
   #   homeDirectory = "/home/eyanm";
   #   homeStateVersion = "24.11";
      
   #  };
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
	inherit system;
	specialArgs = { 
	  # pass config variables declared above
	  inherit inputs;

	  };
	modules = [
	  ./configuration.nix
	  home-manager.nixosModules.home-manager 
	    {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.eyanm = import ./home/default.nix;
            home-manager.backupFileExtension = "backup";   # Automatically backup conflicting files
	    }
	  ];

      };
    };

    # USE THIS SECTION WHEN CONFIGURING ON NON NIXOS SYSTEMS
    # homeConfigurations = {
      ## This will match the username in variables.nix
     # ${user}@${host} = home-manager.lib.homeManagerConfiguration {
       # inherit ${system;
       # pkgs = nixpkgs.legacyPackages.system;
       # extraSpecialArgs = { inherit inputs; };
       # modules = [
         # ./home/default.nix
       # ];
     # };
   # };

  };
} # module end


