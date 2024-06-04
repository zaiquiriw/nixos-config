# hosts/zephyr/configuration.nix

# Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{ config, lib, pkgs, inputs, ... }:
let 
  system = pkgs.system;

in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../nixosModules
    ];

  # Access agenix secrets
  # age = {
  #  secrets = {
  #    zaiqPassword = {
  #      file = ./secrets/primary.age;
  #      owner = "zaiq";
  #      group = "zaiq";
  #    };
  #  };
  #};

  # Add ssh support
  services.openssh.enable = true;
  
  networking.networkmanager.enable = true;
  
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };

  # Test if vm works and git is installed
  users.users.zaiq = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialPassword = "test";
    # config.age.secrets.zaiqPassword.path;
  };

  # Access inputs from the flake to add agenix
  # environment.systemPackages = [
  #  inputs.agenix.packages."${system}".default
  # ];

  virtualisation.vmVariant = {
    # following configuration is added only when building VM with build-vm
    virtualisation = {
      memorySize =  4096; # Use 2048MiB memory.
      cores = 3;   
      sharedDirectories.userSSH = { 
        source = "/home/zaiq/.ssh";
        target = "/home/zaiq/.ssh";
      };
      sharedDirectories.hostSSH = {
        source = "/etc/ssh";
        target = "/etc/ssh";
      };
    };
  };

  # Copy config folder into etc of the new system
  # environment.etc."nixos-config" = {
  #  source = ../../flake.nix;
  #  mode = "";
  # };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}
