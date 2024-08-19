{ config, pkgs, ... } : {
  home.packages = [
    pkgs.nixd
  ];

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
      # pkgs.vimPlugins.something
    ];
    extraLuaConfig = ''
      ${builtins.readFile nvim/lspconfig.lua}
    ''
  };
}
