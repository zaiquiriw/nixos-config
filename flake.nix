# flake.nix

{
  description = "Zaiq and Liz's Nixos Configs!";

  inputs = {
    ######################### Official NixOS and HM Package Sources ###########

    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    ##################################################### Utilities ###########

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Declaritive disk partitioning https://github.com/nix-community/disko
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ########################################### Desktop Environment ###########

    # Dynamic tiling with Wayland https://hyprland.org/
    # They have a stable package but I'm okay using the unstable version
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    # A library for managing hyprland widgets
    ags.url = "github:Aylur/ags";

    # Neovim built within Nix https://github.com/nix-community/nixvim
    nixvim = {
      #url = "github:nix-community/nixvim/nixos-23.11";
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    ####################################### Sources and Inspiration ###########

      # EmergentMind  https://www.youtube.com/@Emergent_Mind
      # Vimjoyer      https://www.youtube.com/@vimjoyer
      # Ryan4yin      https://nixos-and-flakes.thiscute.world/
      # Misterio77    https://github.com/Misterio77/nix-config

      # This Repo     https://github.com/zaiquiriw/nixos-config
      # Secret Repo   [TODO]

  };

  outputs = inputs @ {
    self, 
    nixpkgs, 
    nixpkgs-unstable, 
    home-manager, 
    sops-nix, 
    hyprland,
    nixos-hardware, ... }: 
    let
      
      ####################################### Convenience Utilities ###########

      inherit (self) outputs;
      
      
      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
      ];
      
      
      inherit (nixpkgs) lib;

      
      configVars = import ./vars { inherit inputs lib; };
      configLib = import ./lib { inherit lib; };
      
      
      specialArgs = { inherit inputs outputs configVars configLib nixpkgs; };

    in {

      devShells = forAllSystems
        (system:
          let pkgs = nixpkgs.legacyPackages.${system};
          in import ./shell.nix { inherit pkgs; }
        );

      ###################################### Modular Config Imports ###########

      # Custom modules to enable special functionality for nixos or 
      # home-manager oriented configs.
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      # Custom modifications/overrides to upstream packages.
      overlays = import ./overlays { inherit inputs outputs; };

      # Custom packages to be shared or upstreamed.
      packages = forAllSystems
        (system:
          let pkgs = nixpkgs.legacyPackages.${system};
          in import ./pkgs { inherit pkgs; }
        );

      ################################# Host/Machine Configurations ###########

      nixosConfigurations = {


        zephyr = nixpkgs.lib.nixosSystem {
          
          inherit specialArgs;
          modules = [
	    # Include host configuration, and public hardware configuration
            # nixos-hardware.nixosModules.asus-zephyrus-ga503
            ./hosts/zephyr
            inputs.disko.nixosModules.default 
          ];
        };
        
        
        theoreticalHost = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [
            ./hosts/guest
          ];
        };
      };

      ########################################## User Configuration ###########

      homeConfigurations = {
        zaiq = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {inherit inputs outputs;};
          modules = [
            ./users/zaiq
          ];
        };
      };
    };
}
