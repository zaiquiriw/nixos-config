# users/zaiq/home.nix
# Contains some basic home-manager configuration
{ config, pkgs, inputs, outputs, lib, ... }:

{
    imports = [
      ./hyprland
      ./themes
      ./gnome
      ./nixvim
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
    themes.enable = lib.mkDefault true;
    gnome.enable = lib.mkDefault true;
    extensions.enable = lib.mkDefault true;


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
        gimp
        unstable.ollama
        chromium
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
