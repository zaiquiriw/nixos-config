{ lib, config, pkgs, inputs, ... }: {

    imports = [
        # Additional modules
    ];

    options = {
        themes.enable = lib.mkEnableOption "Nixvim, it's config scripts, and plugins";
    };

    config = lib.mkIf config.themes.enable {
        # All of the actual config, can use extra options
    };

}