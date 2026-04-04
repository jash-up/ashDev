{
  description = "Modern C++03 Development Environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.gcc        # The GNU Compiler Collection (includes g++)
            pkgs.neovim     # Your text editor
            pkgs.gnumake    # Useful if you want to use Makefiles later
            pkgs.gdb        # The debugger
          ];

          shellHook = ''
            echo "--- 🛠️ Native C++ Environment ---"
            echo "Compiler: $(g++ --version | head -n 1)"
            echo "To compile C++03: g++ -std=c++03 main.cpp -o program"
          '';
        };
      }
    );
}
