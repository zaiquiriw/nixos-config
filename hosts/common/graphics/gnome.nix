# /hosts/common/graphics/gnome.nix

# This file configures everything required for gnome, the default DE for any
# any configured machine

{ config, lib, pkgs, ... } : {
    options = {
        gnome.enable = lib.mkEnableOption "All tools relevant to the gnome desktop environment";
    };

    config = lib.mkIf config.gnome.enable {
        # Turn on xserver, gnome DE, and the gnome session manager gdm
	services.xserver = {
            enable = true;
	    displayManager.gdm = {
                enable = true;
		wayland = true;
	    };
	    desktopManager.gnome.enable = true;
	};
    };
}
