# users/zaiq/home.nix

# This file is only for user info, and importing in all the other supporting
# configuration for this user. Other packages and applications will be imported
# and set in separate files (or folders if warranted). The user's configuration
# should be explicitly things the user may want to have on every system they
# use, settings that feel personal, and are somewhat separate from the host's
# core purpose or functionality.

# Purpose of inputs:
# - config:  
# - pkgs:    
# - inputs:  
# - outputs: 
# - lib:     
{ config, pkgs, inputs, outputs, lib, ... }:

{
    
    imports = [
        ./browsers.nix
	./programming.nix
    ];

    #-------------#
    # USER CONFIG #
    #-------------#

    browsers.enable = true;

    #-------------#
    # USER CONFIG #
    #-------------#

    # Basic user information
    home.username = "zaiq";
    home.homeDirectory = "/home/zaiq";

    # Configure nixpkgs to use the overlays, like the unstable version set up
    # in the flake. As well as any other nixpkgs config
    nixpkgs = {
        overlays = [
	    outputs.overlays.unstable-packages
	];
	config = {
             # allowUnfree = true;
	};
    };
  
    # Have custom setting inputs per application, or in a central file
    home.file = {
        # Add some custom files here
    };

    # Don't change, enables home-manager and maintains defaults for critical app
    home.stateVersion = "24.05";
    programs.home-manager.enable = true;
}
