# nixosModules/common.nix

{ config, pkgs, lib, ... }: {
    options = {
        common.enable =
            lib.mkEnableOption "Enable common.nix";
    };

    # If the module is enabled, add git to the systemPackages
    config = lib.mkIf config.common.enable {
        environment.systemPackages = with pkgs; [
            git
            unstable.home-manager
        ];

        nix.settings.experimental-features = "nix-command flakes";
    };
}