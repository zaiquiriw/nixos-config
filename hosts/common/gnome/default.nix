{config, lib, pkgs, ...} : {
    options = {
        gnome.enable = lib.mkEnableOption "Enable all tools relevant to the gnome desktop environment";
    };

    config = {
        # Turn on xserver, gnome DE, and the gnome session manager gdm
	services.xserver = {
            enable = true;
	    displayManager.gdm.enable = true;
	    desktopManager.gnome.enable = true;
	};
    };
}
