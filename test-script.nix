{
  pkgs ? import <nixpkgs> { },
  bc-lua-core ? import ./default.nix { },
}:

let
  test_logger = pkgs.writeScriptBin "test_logger" ''
    set -euo pipefail
    echo Hello World
  '';
in
pkgs.stdenv.mkDerivation {
  name = "test_scripts";
  src = ./.;

  propagatedBuildInputs = [ bc-lua-core ];

  installPhase = ''
    mkdir -p $out/bin
    cp -r ${test_logger} $out/bin/test_logger
  '';
}
