# hosts/common/core.nix

{ config, pkgs, lib, ... }: {
    options = {
        core.enable =
            lib.mkEnableOption "Enable my core nix features";
    };

    # If the module is enabled, add git to the systemPackages
    config = lib.mkIf config.core.enable {
        environment.systemPackages = with pkgs; [
            git
            unstable.home-manager
	        acpi
        ];

        nix.settings.experimental-features = "nix-command flakes";
    };
}
