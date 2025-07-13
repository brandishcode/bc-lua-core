{
  pkgs ? import <nixpkgs> { },
}:

let
  lua = pkgs.lua.withPackages (
    ps: with ps; [
      lualogging
      ansicolors
      busted
    ]
  );
in
pkgs.mkShell {
  packages = [
    lua
    pkgs.luarocks
  ];

  shellHook = ''
    export SHELL=/run/current-system/sw/bin/bash
    export LUA_PATH="$PATH;./lua/?.lua"
  '';
}
