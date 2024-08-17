# hosts/zephyr/default.nix

# Default settings for Zaiq's main computer. This file should simply import
# external configuration and the very basic settings required by a laptop.
# Otherwise, this file will simply turn on and off the common configurations
# shared by hosts, but break out into separate files for this host if needed
# if the settings differ from the shared default.

{ config, lib, pkgs, inputs, ... }:

{  
  imports =
    [
      ./hardware-configuration.nix
      # ./disko.nix TODO add disko (will be part of adding impermanance) 
      ../common
    ];

  #-------------#
  # SET OPTIONS #
  #-------------# 

  # Nothing yet

  #-------------#
  # USER CONFIG #
  #-------------#

  users.users.zaiq = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialPassword = "test";
  };

  # TODO Configure system resources when built as a vm in a separate file
  virtualisation.vmVariant = {
      virtualisation = {
      memorySize =  4096; # Use 2048MiB memory.
      cores = 3;         
    };
  }; 
  
  #-------------#
  #   NETWORK   #
  #-------------#

  # Turn on wifi management
  networking.networkmanager.enable = true;

  #-------------#
  # BOOT LOADER #
  #-------------#

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Don't change, manages the default version of critical applications
  system.stateVersion = "24.05"; # Did you read the comment?

}
