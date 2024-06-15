# hosts/common/MODULE.nix

{ config, pkgs, lib, ... }: {
    options = {
        MODULE.enable =
            lib.mkEnableOption "MODULE DESCRIPTION";
    };

    # If the module is enabled, add git to the systemPackages
    config = lib.mkIf config.MODULE.enable {
        
    };
}