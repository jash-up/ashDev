{
  description = "Python development shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            python312
            python312Packages.pip
            python312Packages.virtualenv
          ];

          shellHook = ''
            echo  "Python Nix Shell Loaded"

            if [ ! -d .venv ]; then
              python -m venv .venv
            fi

            source .venv/bin/activate
          '';
        };
      });
}

