{ pkgs, ... } : {
  home.packages = [
    pkgs.obsidian
    pkgs.discord
    pkgs.libreoffice-qt
    pkgs.hunspell
    pkgs.hunspellDicts.en-us-large
    pkgs.pandoc
    pkgs.tectonic-unwrapped
    pkgs.anki-bin
  ];
}
