{inputs, ... }: {
    additions = final: prev: import ../pkgs { pkgs = final; };

    modifications = final: prev: {

    };

    unstable-packages = final: prev: {
        unstable = import inputs.nixpkgs-unstable {
            system = final.system;
	};
    };
}
