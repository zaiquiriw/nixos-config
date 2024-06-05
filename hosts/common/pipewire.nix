# hosts/common/pipewire.nix

{ config, pkgs, lib, ... } : {
  options = {
    pipewire.enable = lib.mkEnableOption "Enable a basic PipeWire config";
  };

  config = lib.mkIf config.pipewire.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;
    };

    hardware.pulseaudio.enable = false;
  };
}
