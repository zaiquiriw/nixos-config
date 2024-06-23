# hosts/common/core.nix

{ config, pkgs, lib, inputs, ... }: {
    options = {
        hyprland.enable =
            lib.mkEnableOption "Enable my core nix features";
    };

    # If the module is enabled, add git to the systemPackages
    config = lib.mkIf config.hyprland.enable {
        nix.settings = {
            substituters = ["https://hyprland.cachix.org"];
            trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
        };

        programs.hyprland = {
            enable = true;
            package = inputs.hyprland.packages."${pkgs.system}".hyprland; 
        };
    };
}

  
  