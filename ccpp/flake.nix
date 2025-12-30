{
	description = "C und C++ development nix shellll loll";

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
						gcc
						clang
						gdb
						lldb
						cmake
						ninja
						gnumake
						pkg-config
						bear
						valgrind
					];

					shellHook = ''
						echo "c und c++ nix shell loaded and lockjed bitxh"

						export CC=clang
						export CXX=clang++

						export CFLAGS="-Wall -Wextra -Wpedantic -02"
						export CXXFLAGS="-Wall -Wextra -Wpedantic -02 -std=c++20"
					'';
				};
			});
}
