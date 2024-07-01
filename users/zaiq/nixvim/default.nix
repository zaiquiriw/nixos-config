{ config, pkgs, inputs, ... }:

{   
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];

  programs.nixvim = {
    enable = true;

    plugins.lightline.enable = true;

    extraPlugins = with pkgs.vimPlugins; [
      # https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=vimPlugins
      # Extra plugins managed 
    ];
  }; 
}
