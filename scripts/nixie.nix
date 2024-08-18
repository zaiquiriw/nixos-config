# /scripts/nixie.nix

# This file creates a bash script accessible by all hosts that automates
# some of the basic configuration steps of nixos.

{ pkgs }:

pkgs.writeShellScriptBin "nixie" ''
    echo "hello world" | ${pkgs.cowsay}/bin/cowsay | ${pkgs.lolcat}/bin/lolcat
''
