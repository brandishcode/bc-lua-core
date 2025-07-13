{
  pkgs ? import <nixpkgs> { },
}:

pkgs.luaPackages.buildLuarocksPackage {
  pname = "bc-lua-core";
  version = "dev-1";
  src = ./.;

  propagatedBuildInputs = [
    pkgs.luaPackages.ansicolors
    pkgs.luaPackages.lualogging
  ];
}
