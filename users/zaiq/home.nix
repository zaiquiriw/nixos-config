# users/zaiq/home.nix
# Contains some basic home-manager configuration
{ config, pkgs, ... }:

{
    home.username = "zaiq";
    home.homeDirectory = "/home/zaiq";
  
    home.packages = [
        pkgs.neovim
        pkgs.git
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