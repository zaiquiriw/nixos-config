# hosts/common/default.nix

# This is where the configuration of shared host configs take place. This file
# should only import separate configurations that can be opted into from the
# host side, with the exception of Core, which should be on for every host.

{ config, pkgs, lib, outputs, ... }: {
    imports = [
        ./core.nix
	./graphics.nix
    ];

    # All packages here will use overlays
    nixpkgs = {
        overlays = builtins.attrValues outputs.overlays;
        config = {
            # Configuration of nixpkgs for all of the system modules
        };
    };

    core.enable = lib.mkDefault true;
}
