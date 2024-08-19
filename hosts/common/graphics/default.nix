{config, lib, pkgs, ...} : {
    
    imports =[
        ./gnome.nix
	# ./hyprland.nix
	./cosmic.nix
    ];

    options = {
        graphics.enable = lib.mkEnableOption "All basic graphical settings for machines";
    };

    config = lib.mkIf config.graphics.enable {
        # Turn on gnome by default if someone enables graphics
        gnome.enable = lib.mkDefault true;
    };
}
