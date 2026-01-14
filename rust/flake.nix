{
	description = "Rust development nix shell";

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
						rustc
						cargo
						rustfmt
						clippy
						pkg-config
						openssl
						zlib
						lldb
						gdb
						rust-analyzer
					];

					shellHook = ''
						echo "Rust nix shell guns blazin"

						export RUST_BACKTRACE=1
					'';
				};
			});
}
