{ lib, config, pkgs, inputs, ... }: {

    imports = [
        # Custom gnome package stuff? idk
    ];

    options = {
        gnome.enable = lib.mkEnableOption "All of the gnome stuff, gdm, gnome-shell, apps, etc.";
        extensions.enable = lib.mkEnableOption "Disable extensions for gnome (testing)";
    };

    config = lib.mkIf config.gnome.enable {
        dconf = {
            enable = true;
            settings."org/gnome/shell" = {
                disable-user-extensions = false;
                enabled-extensions = with pkgs.gnomeExtensions; [
                    blur-my-shell.extensionUuid
                    gsconnect.extensionUuid
                ];
            };
        };
    };
}

    