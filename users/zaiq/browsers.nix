# /users/zaiq/browsers.nix

# This file has options accross all the browsers, like enabling them, common
# theming options, etc.

{ lib, config, pkgs, inputs, ... }: {
    imports = [
        ./firefox.nix
	# ./chrome.nix
    ];

    options = {
        browsers.enable = lib.mkEnableOption "All browsers configured with their default options.";
    };

    config = lib.mkIf config.browsers.enable {
        firefox.enable = true;
    };
}
