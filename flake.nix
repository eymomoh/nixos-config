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
    system = "x86_64-linux"; # set system architecture
   # user = "eyanm"; # set username here
   # host = "nixos"; # set system hostname here
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
	inherit system;
	specialArgs = { inherit inputs; };
	modules = [
	  ./configuration.nix
	  home-manager.nixosModules.home-manager 
	  {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users = {
	      "eyanm" = import ./home/default.nix;
	    };
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


