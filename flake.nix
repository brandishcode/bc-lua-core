{
  description = "Personal lua-core library";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    bcformatter.url = "github:brandishcode/brandishcode-formatter";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      bcformatter,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {

        formatter = bcformatter.formatter.${system};
        devShells.default = import ./shell.nix { inherit pkgs; };
        packages.default = import ./default.nix { inherit pkgs; };
        checks.default = import ./checks.nix {
          inherit pkgs;
        };

      }
    );
}
