{ pkgs, config, ... } : {
  home.packages = [
    pkgs.nixd
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      # add_newline = false;

      # character = {
      #   success_symbol = "[➜](bold green)";
      #   error_symbol = "[➜](bold red)";
      # };

      # package.disabled = true;
    };
  };

  fonts.fontconfig.enable = true;

  programs.direnv = {
    enable = true;
  };

  programs.git = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = [
      pkgs.vimPlugins.nvim-lspconfig
    ];
    extraLuaConfig = ''
      ${builtins.readFile nvim/lspconfig.lua}
    '';
  };
}
