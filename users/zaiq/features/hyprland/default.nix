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
    # GTK Theming library
    programs.ags = {
      enable = true;

      # null or path, leave as null if you don't want hm to manage the config
      configDir = ./ags;

      # additional packages to add to gjs's runtime
      extraPackages = with pkgs; [
        gtksourceview
        webkitgtk
        accountsservice
      ];
    };

    home.packages = with pkgs; [
      grimblast
      hyprpicker
      waybar
      swww
    ];

    home.pointerCursor = {
      gtk.enable = true;
      # x11.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 16;
    };

    gtk = {
      enable = true;
      theme = {
        package = pkgs.flat-remix-gtk;
        name = "Flat-Remix-GTK-Grey-Darkest";
      };

      iconTheme = {
        package = pkgs.gnome.adwaita-icon-theme;
        name = "Adwaita";
      };

      font = {
        name = "Sans";
        size = 11;
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;

      settings = {

        "monitor" = ",highres,auto,1";

        "$mod" = "SUPER";

        bind = [
          "$mod, F, exec, firefox"
          "$mod, T, exec, kitty"
          "$mod, V, exec, code"
          "$mod, O, exec, obsidian"
          "$mod, R, exec, hyprctl reload"
          "$mod, M, exec, hyprctl dispatch exit"
        ];
      };
    };

    home.file.".config/hypr/colors".text = ''
      $background = rgba(1d192bee)
      $foreground = rgba(c3dde7ee)

      $color0 = rgba(1d192bee)
      $color1 = rgba(465EA7ee)
      $color2 = rgba(5A89B6ee)
      $color3 = rgba(6296CAee)
      $color4 = rgba(73B3D4ee)
      $color5 = rgba(7BC7DDee)
      $color6 = rgba(9CB4E3ee)
      $color7 = rgba(c3dde7ee)
      $color8 = rgba(889aa1ee)
      $color9 = rgba(465EA7ee)
      $color10 = rgba(5A89B6ee)
      $color11 = rgba(6296CAee)
      $color12 = rgba(73B3D4ee)
      $color13 = rgba(7BC7DDee)
      $color14 = rgba(9CB4E3ee)
      $color15 = rgba(c3dde7ee)
    '';
  }; 
}
