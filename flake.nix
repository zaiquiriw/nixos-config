# flake.nix

{
  description = "Zaiq and Liz's Nixos Configs!";

  inputs = {
    ######################### Official NixOS and HM Package Sources ###########

    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    hardware.url = "github:nixos/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };


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
    hyprland, ... }: 
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
            # agenix.nixosModules.default
            sops-nix.nixosModules.sops
          ];
        };
        theoreticalHost = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {inherit inputs;};
          modules = [
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable ]; })
            ./hosts/theoreticalHost/configuration.nix
            # agenix.nixosModules.default
          ];
        };
      };

      homeConfigurations = {
        zaiq = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          extraSpecialArgs = {inherit inputs;};
          modules = [
            ./home/zaiq/home.nix
          ];
        };
      };
    };
}
