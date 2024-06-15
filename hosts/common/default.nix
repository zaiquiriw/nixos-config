# hosts/common/default.nix

{ config, pkgs, lib, outputs, ... }: {
    imports = [
        ./core.nix
	    ./pipewire.nix
    ];

    nixpkgs = {
        # you can add global overlays here
        overlays = builtins.attrValues outputs.overlays;
        config = {
        allowUnfree = true;
        };
    };

    core.enable = lib.mkDefault true;
    pipewire.enable = lib.mkDefault true;
    gnome.enable = lib.mkDefault true;
}
