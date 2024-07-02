{ config, pkgs, inputs, ... }:

{   
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];

  programs.nixvim = {
    enable = true;
  
    plugins = {
      lightline.enable = true;

      lsp = {
        enable = true;
        servers = {
          rust-analyzer = {
	    enable = true;
	    installCargo = true;
	    installRustc = true;
	  };
        };
      };
    };

    extraPlugins = with pkgs.vimPlugins; [
      
      # Extra plugins managed 
    ];
  };
  
  #programs.neovim = {
  #  enable = true;
  #  extraLuaConfig = ''
  #    -- Write lua config here, or in the lua config file
  #
  #    -- File imported below:
  #    ${builtins.readFile ./init.lua}
  #  '';
  #};
}
