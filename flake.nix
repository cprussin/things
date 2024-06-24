{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    mkCli.url = "github:cprussin/mkCli";
    smooth-prim = {
      url = "github:rcolyer/smooth-prim";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    flake-utils,
    mkCli,
    smooth-prim,
    ...
  }: (
    flake-utils.lib.eachDefaultSystem
    (
      system: let
        cli-overlay = _: prev: {
          cli = prev.lib.mkCli "cli" {
            _noAll = true;

            build = pkgs.writeShellScript "build" ''
              mkdir -p ./build/$(dirname ''$1)
              ${pkgs.openscad}/bin/openscad -o ./build/''${1%%.scad}.stl $1
            '';

            test.nix = {
              lint = "${prev.statix}/bin/statix check --ignore node_modules .";
              dead-code = "${prev.deadnix}/bin/deadnix --exclude ./node_modules .";
              format = "${prev.alejandra}/bin/alejandra --exclude ./node_modules --check .";
            };

            fix.nix = {
              lint = "${prev.statix}/bin/statix fix --ignore node_modules .";
              dead-code = "${prev.deadnix}/bin/deadnix --exclude ./node_modules -e .";
              format = "${prev.alejandra}/bin/alejandra --exclude ./node_modules .";
            };
          };
        };

        pkgs = import nixpkgs {
          inherit system;
          overlays = [mkCli.overlays.default cli-overlay];
          config = {};
        };
      in {
        devShells.default = pkgs.mkShell {
          OPENSCADPATH = pkgs.linkFarm "openscad-path" [
            {
              name = "smooth-prim";
              path = smooth-prim;
            }
          ];

          buildInputs = [
            pkgs.cli
            pkgs.freecad
            pkgs.git
            pkgs.openscad
            pkgs.prusa-slicer
          ];
        };
      }
    )
  );
}
