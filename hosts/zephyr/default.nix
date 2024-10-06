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
      ./disko.nix 
      ../common
    ];

  #-------------#
  # SET OPTIONS #
  #-------------# 

  graphics.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  hardware.openrazer.enable = true;
  environment.systemPackages = with pkgs; [
    openrazer-daemon
    polychromatic
    qemu
    quickemu
    mullvad
  ];

  nixpkgs.config.allowUnfree = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };


  #-------------#
  # USER CONFIG #
  #-------------#

  users.users.zaiq = {
    isNormalUser = true;
    extraGroups = [ "wheel" "openrazer" ];
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
  networking = {
    hostName = "nixie";
    # enableIPv6 = false;
    networkmanager = {
      enable = true;
    };
    interfaces.enp3s0 = {
    };
  };
  # Configure via cups at localhost:631
  services.printing.enable = true;
  services.printing.browsedConf = ''
      BrowseDNSSDSubTypes _cups,_print
      BrowseLocalProtocols all
      BrowseRemoteProtocols all
      CreateIPPPrinterQueues All 
      BrowseProtocols all
    '';
  # services.printing.drivers = [ pkgs.brlaser ];
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  #-------------#
  # BOOT LOADER #
  #-------------#

  boot.loader.grub = {
    enable = true;
    useOSProber = true;
    device = "nodev";
    efiSupport = true;
  };  

  # Don't change, manages the default version of critical applications
  system.stateVersion = "24.05"; # Did you read the comment?

}
