# hosts/common/default.nix

{ config, pkgs, lib, ... }: {
    imports = [
        ./common.nix
	    ./pipewire.nix
    ];

    common.enable = lib.mkDefault true;
    pipewire.enable = lib.mkDefault true;
}
