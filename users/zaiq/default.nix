# users/zaiq/home.nix
# Contains some basic home-manager configuration
{ config, pkgs, inputs, outputs, lib, ... }:

{
    imports = [
      ./features/hyprland
    ];

    nixpkgs = {
      overlays = [
        outputs.overlays.unstable-packages
      ];
      config = {
        allowUnfree = true;
      };
    };

    # Configure optional features
    hyprland.enable = lib.mkDefault false;

    home = {
      username = "zaiq";
      homeDirectory = "/home/zaiq";
    };
    
    home.packages = with pkgs; [
        neovim
        git
	      firefox
        kitty
        unstable.vscode
        discord
        obsidian
        modrinth-app
    ];

    home.sessionVariables = {
        EDITOR = "nvim";
    };

    home.file = {
        # Add some custom files here
    };

    home.stateVersion = "24.05";
    programs.home-manager.enable = true;
}
