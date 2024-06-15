{ lib, config, pkgs, inputs, ... }: {

    imports = [
        # Custom gnome package stuff? idk
    ];

    options = {
        gnome.enable = lib.mkEnableOption "All of the gnome stuff, gdm, gnome-shell, apps, etc.";
        extensions.enable = lib.mkEnableOption "Disable extensions for gnome (testing)";
    };

    config = lib.mkIf config.gnome.enable {
        environment.systemPackages = [ pkgs.libsecret pkgs.gnome.gnome-tweaks ]; # libsecret api needed for keyring access?
        security.pam.services.cosmic-greeter.enableGnomeKeyring = true; 
        services.gnome.gnome-keyring.enable = true;
        programs.seahorse.enable = true;

        services.xserver = {
            enable = true;
            displayManager.gdm.enable = true;
            desktopManager.gnome.enable = true;
        };


        environment.gnome.excludePackages = (with pkgs; [
            gnome-photos
            gnome-tour
        ]) ++ (with pkgs.gnome; [
            cheese # webcam tool
            gnome-music
            gnome-terminal
            epiphany # web browser
            geary # email reader
            evince # document viewer
            gnome-characters
            totem # video player
            tali # poker game
            iagno # go game
            hitori # sudoku game
            atomix # puzzle game
        ]);
    };

    