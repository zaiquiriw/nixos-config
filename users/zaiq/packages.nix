{ pkgs, config, ... } :
  let
    customObsidian = pkgs.symlinkJoin {
      name = "obsidian-with-python";
      paths = [
        pkgs.obsidian
	(pkgs.python3.withPackages (ps: with ps; [
	  jupyter
	]))
      ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/obsidian \
	--prefix PATH : ${pkgs.python3}/bin
      '';
    };
  in {
  home.packages = [
    customObsidian
    pkgs.discord
    pkgs.libreoffice-qt
    pkgs.hunspell
    pkgs.hunspellDicts.en-us-large
    pkgs.pandoc
    pkgs.tectonic-unwrapped
    pkgs.anki-bin
    pkgs.ticktick
    pkgs.gimp
  ];
}
