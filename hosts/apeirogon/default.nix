{ config, lib, pkgs, inputs, ... }:
let
    system = pkgs.system;

in {
    imports =
        [
            ./hardware-configuration.nix
            ./disko.nix
            ../common
        ];
    
    pipewire.enable = true;
    nixpkgs.config.allowUnfree = true;
    time.timeZone = lib.mkDefault "America/Chicago";
    services.openssh.enable = true;
    networking.networkmanager.enable = true;
    programs.zsh.enable = true;

    nix.settings.trusted-users = [ "root" "@wheel" ];
    users.users.kit = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        initialPassword = "test";
        shell = pkgs.zsh;
    }

    boot.loader = {
        efi = {
            canTouchEfiVariables = true;
        };
        grub = {
            enable = true;
            efiSupport = true;
            device = "nodev";
            useOSProber = true;
        };
    };
};

system.stateVersion = "24.05";