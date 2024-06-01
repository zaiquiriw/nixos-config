# flake.nix

{
  description = "NixOS configuration with two or more channels";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, home-manager }:
    let
      system = "x86_64-linux";
      overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
           inherit system;
           config.allowUnfree = true;
        };

      };
    in {
      nixosConfigurations = {
        zephyr = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {inherit inputs;};
          modules = [
          # Overlays-module makes "pkgs.unstable" available in configuration.nix
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable ]; })
            ./hosts/zephyr/configuration.nix  
          ];
        };
        theoreticalHost = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {inherit inputs;};
          modules = [
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable ]; })
            ./hosts/theoreticalHost/configuration.nix
          ];
        };
      };

      homeConfigurations = {
        zaiq = home-manager.lib.homeManagerConfiguration {
          inherit system;
          pkgs = nixpkgs.legacyPackages.${system};
          specialArgs = {inherit inputs;};
          modules = [
            ./users/zaiq/home.nix
          ];
        };
      };
    };
}