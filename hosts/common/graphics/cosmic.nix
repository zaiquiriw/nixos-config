# /hosts/common/graphics/cosmic.nix

# This file enables the cosmic desktop enviornment and greeter as packaged in it's alpha
# state.

{ config, lib, pkgs, ... } : {
    options = {
        cosmic.enable = lib.mkEnableOption "Cosmic desktop environment and session manager by System76";
    };

    config = lib.mkIf config.cosmic.enable {
      services.desktopManager.cosmic.enable = true;
      services.displayManager.cosmic-greeter.enable = true;
    };
}
