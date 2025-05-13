# installs home-manager as nix module to allow combined rebuild
{ inputs, outputs, ... }: {
  imports = [
    # Import home-manager's NixOS module
    inputs.home-manager.nixosModules.home-manager
  ];


  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      # Import your home-manager configuration
      helios = import ./home/helios/heliosHome.nix;
    };
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;

  };
}
