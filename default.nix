{
  pkgs ? import <nixpkgs> { },
}:

pkgs.luaPackages.buildLuarocksPackage {
  pname = "bc-lua-core";
  version = "dev-1";
  src = ./.;

  doInstallCheck = true;
  installCheckPhase = ''
    runHook preInstallCheck
    luarocks test
    runHook postInstallCheck
  '';

  propagatedBuildInputs = [
    pkgs.luaPackages.ansicolors
    pkgs.luaPackages.lualogging
    pkgs.luaPackages.busted
  ];
}
