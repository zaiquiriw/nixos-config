# users/zaiq/home.nix
# Contains some basic home-manager configuration
{ config, pkgs, inputs, ... }:

{
    imports = [
      ./nixvim
      ./basic/git.nix
      ./basic/email.nix
      ./hyprland
    ];

    home = {
      home.username = "zaiq";
      home.homeDirectory = "/home/zaiq";
    };
    
    home.packages = with pkgs; [
        neovim
        git
	      firefox
        kitty
        vscode
        discord
        obsidian
    ];
    
    nixpkgs.config.allowUnfree = true;

    home.sessionVariables = {
        EDITOR = "nvim";
    };

    home.file = {
        # Add some custom files here
    };

    home.stateVersion = "24.05";
    programs.home-manager.enable = true;
}
