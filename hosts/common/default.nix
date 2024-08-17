# hosts/common/default.nix

# This is where the configuration of shared host configs take place. This file
# should only import separate configurations that can be opted into from the
# host side, with the exception of Core, which should be on for every host.

{ config, pkgs, lib, ... }: {
    imports = [
        ./core.nix
	./graphics
    ];

    core.enable = lib.mkDefault true;
}
