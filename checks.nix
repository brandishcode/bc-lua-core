{
  pkgs ? import <nixpkgs> { },
}:

let
  script = import ./test-script.nix { inherit pkgs; };
in
pkgs.testers.runNixOSTest {
  name = "appender";
  nodes = {
    machine =
      { ... }:
      {
        users.users.tester = {
          isSystemUser = true;
          extraGroups = [ "wheel" ];
          group = "tester";
        };

        users.groups.tester.gid = 1000;

        systemd.services.testerTest = {
          wantedBy = [ "multi-user.target" ];
          script = ''
            exec ${script}/bin/test_logger
          '';
          serviceConfig = {
            Group = "tester";
          };
        };
      };
  };
  testScript = ''
    machine.start()
    machine.wait_for_unit("testerTest.service")
  '';
}
