# nixosModules/default.nix

{ config, pkgs, lib, ... }: {
    imports = [
        ./common.nix
    ];

    common.enable = lib.mkDefault true;
}