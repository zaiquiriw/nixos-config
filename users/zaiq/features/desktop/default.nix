{ lib, config, pkgs, inputs, ... }: {

  imports = [
    ./basic-binds.nix
    inputs.ags.homeManagerModules.default
  ];

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
      ];
    };
  };
}
