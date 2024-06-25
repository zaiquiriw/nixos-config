{ lib, config, pkgs, inputs, ... }: {

  imports = [
    ./hypr-env.nix
    inputs.ags.homeManagerModules.default
  ];

  options = {
    hyprland.enable = lib.mkEnableOption "Enable the usage of hyprland";
    hypr-startup.enable = lib.mkEnableOption "Enable hyprland to autostart";
  };

  config = lib.mkIf config.hyprland.enable {
    home.packages = with pkgs; [
    
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$mod" = "SUPER";
        bind = [
          "$mod, F, exec, firefox"
          "$mod, T, exec, kitty"
          "$mod, R, exec, hyprctl reload"
          "$mod, M, exec, hyprctl dispatch exit"
        ];
      };
    };
  }; 
}
