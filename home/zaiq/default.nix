# users/zaiq/home.nix
# Contains some basic home-manager configuration
{ config, pkgs, inputs, ... }:

{
    home.username = "zaiq";
    home.homeDirectory = "/home/zaiq";
    
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

    wayland.windowManager.hyprland.settings = {
      "$mod" = "$SUPER";
      bind = 
        [
          "$mod, F, exec, firefox"
          "$mod, T, exec, kitty"
	  "$mod, V, exec, vscode"
	];
    };

    wayland.windowManager.hyprland.plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
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
