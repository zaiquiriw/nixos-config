{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  programs.starship.settings = {
    lua.symbol = mkDefault " ";
  };
}
