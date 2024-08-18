# flake.nix

{
  description = "NixOS configuration with two or more channels";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, home-manager }:
    let
      inherit (self) outputs;
      system = "x86_64-linux";     
      
      specialArgs = { inherit inputs outputs; };

    in {
      overlays = import ./overlays { inherit inputs outputs; };

      nixosConfigurations = {
        zephyr = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = [
            ./hosts/zephyr/default.nix
          ];
        }; 
      };

      homeConfigurations = {
        zaiq = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
	  # Figure out why I had to put outputs here
          extraSpecialArgs = {inherit inputs outputs;};
          modules = [
            ./users/zaiq/default.nix
          ];
        };
      };
    };
}
