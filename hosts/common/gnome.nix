{config, lib, pkgs, ...} : {
    options = {
        gnome.enable = lib.mkEnableOption "Enable my core nix features";
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
}
    };

}