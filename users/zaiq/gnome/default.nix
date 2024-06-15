{ lib, config, pkgs, inputs, ... }: {

    imports = [
        # Custom gnome package stuff? idk
    ];

    options = {
        gnome.enable = lib.mkEnableOption "All of the gnome stuff, gdm, gnome-shell, apps, etc.";
        extensions.enable = lib.mkEnableOption "Disable extensions for gnome (testing)";
    };

    config = lib.mkIf config.gnome.enable {
        
    };
}

    