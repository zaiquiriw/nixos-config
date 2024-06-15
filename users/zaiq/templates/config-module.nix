{ lib, config, pkgs, inputs, ... }: {

    imports = [
        # Additional modules
    ];

    options = {
        MODULE.enable = lib.mkEnableOption "Describe all the module configures";
        # Add more options for even more bits and bobs.
    };

    config = lib.mkIf config.MODULE.enable {
        # All of the actual config, can use extra options
    };