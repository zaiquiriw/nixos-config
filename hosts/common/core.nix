# hosts/common/core.nix
{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    core.enable =
      lib.mkEnableOption "Enable the basic requirements of every host";
  };

  # Default packages that should be on for every system
  config = lib.mkIf config.core.enable {
    environment.systemPackages = with pkgs; [
      git
      unstable.home-manager
      wl-clipboard
    ];

    # This network should use flakes extensively, on by default
    nix.settings.experimental-features = "nix-command flakes";
  };
}
