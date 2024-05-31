# nixosModules/default.nix

{ config, pkgs, ... }: {
    imports = [
        ./common.nix
    ]

    common.enable = lib.mkDefault true;
}