{ config, pkgs, inputs, outputs, lib, ... }:

{
    imports = [

    ];

    nixpkgs = {
        overlays = [
            outputs.overlays.unstable-packages
        ];
        config = {
            allowUnfree = true;
        };
    };

    home = {
        username = "kit";
        homeDirectory = "/home/kit";
    };

    home.packages = with pkgs; [

    ]

    home.sessionVariables = {
        EDITOR = "nvim";
    }

    home.stateVersion = "24.05";
    programs.home-manager.enable = true;
};