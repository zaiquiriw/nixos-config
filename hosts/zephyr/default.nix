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
      ../common
    ];

  # Droidcam extra boot options
  boot.kernelModules = [
    "v4l2loopback" # Webcam loopback
  ];
  boot.extraModulePackages = [
    pkgs.linuxPackages.v4l2loopback # Webcam loopback
  ];
  environment.systemPackages = with pkgs; [
    v4l-utils
    android-tools
    adb-sync
    vlc
    libvlc
  ];

  # Set modules with custom options
  pipewire.enable = true;
  gnome.enable = true;
  hyprland.enable = true;
  
  nixpkgs.config.allowUnfree = true;

  time.timeZone = lib.mkDefault "America/Chicago";

  # Add ssh support
  services.openssh.enable = true;
  
  networking.networkmanager.enable = true;

  #services.desktopManager.cosmic.enable = true;
  #services.displayManager.cosmic-greeter.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1"; 

  # Test if vm works and git is installed
  users.users.zaiq = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialPassword = "test";
    # config.age.secrets.zaiqPassword.path;
  };

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

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}
