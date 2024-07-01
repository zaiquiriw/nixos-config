# users/zaiq/home.nix
# Contains some basic home-manager configuration
{ config, pkgs, inputs, outputs, lib, ... }:

{
    imports = [
      ./hyprland
      ./themes
      ./gnome
      ./nixvim
    ];

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
    };

    # https://starship.rs/guide/
    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {

      };
    };

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

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
      extraConfig = ''
        local config = {}

        config.font = wezterm.font("FiraCode Nerd Font")
        config.font_size = 16.0
        config.hide_tab_bar_if_only_one_tab = true
	config.window_background_opacity = .9

        return config

      '';
    };

    # https://discourse.nixos.org/t/home-manager-nerdfonts/11226
    fonts.fontconfig.enable = true;

    # To use vscode home manager config
    # https://nixos.wiki/wiki/Visual_Studio_Code
    programs.vscode = {
      enable = true;
      package = pkgs.unstable.vscode;
      userSettings = {
        "editor.fontFamily" = "FiraCode Nerd Font Mono";
        "editor.fontLigatures" = true;
        "editor.fontSize" = 16;
        "editor.fontWeight" = "400";
        "editor.lineHeight" = 24;
        "editor.tabSize" = 2;
        "editor.wordWrap" = "on";
        "editor.formatOnSave" = true;
        "editor.formatOnPaste" = true;
        "editor.formatOnType" = true;
        "editor.minimap.enabled" = false;
        "editor.renderWhitespace" = "all";
        "editor.rulers" = "[80, 120]";
        "editor.snippetSuggestions" = "top";
        "editor.suggestSelection" = "first";
        "editor.wordWrapColumn" = 120;
        "files.autoSave" = "afterDelay";
        "files.autoSaveDelay" = 1000;
        "files.trimTrailingWhitespace" = true;
        "files.insertFinalNewline" = true;
        "files.trimFinalNewlines" = true;
        "files.associations" = {
          "*.js" = "javascript";
          "*.jsx" = "javascriptreact";
          "*.ts" = "typescript";
          "*.tsx" = "typescriptreact";
        };
        "workbench.colorTheme" = "Dracula";
        "workbench.iconTheme" = "material-icon-theme";
      };
    };

    home = {
      username = "zaiq";
      homeDirectory = "/home/zaiq";
    };

    home.packages = with pkgs; [
        neovim
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
