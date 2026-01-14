{
  description = "Node.js / npm development shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in {
        devShells.default = pkgs.mkShell {
          name = "node-dev-shell";

          packages = with pkgs; [
            nodejs_22      # LTS, good for Vite/React
            npm-check-updates
            nodePackages.typescript
            nodePackages.typescript-language-server
	    yarn
          ];

          shellHook = ''
            echo "🚀 Node dev shell ready"
            echo "node: $(node --version)"
            echo "npm:  $(npm --version)"
	    export PATH="$PWD/node_modules/.bin/:$PATH"
          '';
        };
      });
}

