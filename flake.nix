{
  description = "My awesome main-flake!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpanel = {
      url = "github:jas-singhfsu/hyprpanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
  
  let
    pkgs = nixpkgs.legacyPackages.${system};
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      sol = nixpkgs.lib.nixosSystem {
	
	inherit system;

	specialArgs = { 
	  inherit inputs;
	};
        modules = [
	  ./configuration.nix
	 # home-manager.nixosModules.home-manager 
	  #  {
           # home-manager.useGlobalPkgs = true;
           # home-manager.useUserPackages = true;
           # home-manager.users.helios = import ./home/helios/heliosHome.nix;
           # home-manager.backupFileExtension = "backup";   # Automatically backup conflicting files
	    #}
	  ./home-manager.nix
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


