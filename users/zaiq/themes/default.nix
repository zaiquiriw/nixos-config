{ lib, config, pkgs, inputs, ... }: {

    imports = [
        # Additional modules
    ];

    options = {
        nixvim.enable = lib.mkEnableOption "Nixvim, it's config scripts, and plugins";
    };

    config = lib.mkIf config.nixvim.enable {
        # All of the actual config, can use extra options
    };