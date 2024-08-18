{ lib, config, pkgs, inputs, ... }: {
    options = {
        firefox.enable = lib.mkEnableOption "Firefox using home-manager custom settings";
    };

    config = lib.mkIf config.firefox.enable {
        programs.firefox.enable = true;
    };
}
