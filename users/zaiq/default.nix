# users/zaiq/home.nix
# Contains some basic home-manager configuration
{ config, pkgs, inputs, ... }:

{
    imports = [
      ./features/desktop
    ];

    home = {
      username = "zaiq";
      homeDirectory = "/home/zaiq";
    };
    
    home.packages = with pkgs; [
        neovim
        git
	      firefox
        kitty
        vscode
        discord
        obsidian
        modrinth-app
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
