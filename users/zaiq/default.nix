# users/zaiq/default.nix
# Contains some basic home-manager configuration
{ config, pkgs, inputs, outputs, lib, ... }:

{
    imports = [
      ./hyprland
      ./themes
      ./gnome
      ./nixvim
      ./starship.nix
      ./starship-symbols.nix
      inputs.nix-colors.homeManagerModules.default
      # Import an unstable program from the unstable input (wild I know)
      # (inputs.home-manager-unstable + "/modules/programs/direnv.nix")
    ];

    colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;

    nixpkgs = {
      overlays = [
        outputs.overlays.unstable-packages
      ];
      config = {
        allowUnfree = true;
      };
    };

    # Configure optional features
    hyprland.enable = lib.mkDefault false;
    gnome.enable = true;
    extensions.enable = lib.mkDefault true;


    # Dev stuff
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv = {
        enable = true;
      };
      config = {
        # Uncomment to hide the wall of env differences when you cd
        # hide_env_diff = true;
      };
    };

    # https://starship.rs/guide/
    #programs.starship = {
   #   enable = true;
  #    enableZshIntegration = true;
 #     settings = {
#
    #  };
    #};

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      envExtra = ''
        export DIRENV_LOG_FORMAT=$'\033[2mdirenv: %s\033[0m'
      '';
      shellAliases = {
        ll = "ls -l";
        update = "sudo nixos-rebuild switch";
      };
      history = {
        size = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
      };
    };

    # https://wezfurlong.org/wezterm/config/lua/wezterm/nerdfonts.html
    programs.wezterm = {
      enable = true;
      enableZshIntegration = true;
      extraConfig = builtins.readFile ./wezterm.lua;
    };

    # https://discourse.nixos.org/t/home-manager-nerdfonts/11226
    fonts.fontconfig.enable = true;

    home = {
      username = "zaiq";
      homeDirectory = "/home/zaiq";
    };

    home.packages = with pkgs; [
        git
        (pkgs.wrapFirefox (pkgs.firefox-unwrapped.override { pipewireSupport = true;}) {})
        kitty
        discord
        obsidian
        modrinth-app
        gimp
        unstable.ollama
        chromium
        droidcam
        obs-studio
        quickemu
        kiwix
        kiwix-tools
        zim
        devenv
        # https://discourse.nixos.org/t/home-manager-nerdfonts/11226
        (nerdfonts.override { fonts = [ "FiraCode"]; })
        (vscode-with-extensions.override {
          vscodeExtensions = with vscode-extensions; [
            bbenoist.nix
          ];
        })
        unstable.vscode
        cachix
        ventoy-full
    ];

    home.sessionVariables = {
        EDITOR = "nvim";
    };

    home.file = {
        # Add some custom files here
    };

    home.stateVersion = "24.05";
    programs.home-manager.enable = true;
}
