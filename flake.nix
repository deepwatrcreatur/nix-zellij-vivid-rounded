{
  description = "Zellij terminal multiplexer with vivid colors, rounded tabs, and Ctrl-Alt keybindings";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    let
      # zjstatus is a WASM plugin — the binary is architecture-independent.
      # Define it once here so the URL/hash stays in a single place.
      zjstatusVersion = "0.17.0";
      zjstatusUrl = "https://github.com/dj95/zjstatus/releases/download/v${zjstatusVersion}/zjstatus.wasm";
      zjstatusSha256 = "1rbvazam9qdj2z21fgzjvbyp5mcrxw28nprqsdzal4dqbm5dy112";
    in
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        zjstatus-wasm =
          (pkgs.fetchurl {
            url = zjstatusUrl;
            sha256 = zjstatusSha256;
          }).overrideAttrs
            (_: {
              meta = {
                description = "zjstatus plugin WASM binary for Zellij (v${zjstatusVersion})";
                homepage = "https://github.com/dj95/zjstatus";
                license = pkgs.lib.licenses.mit;
                platforms = pkgs.lib.platforms.all;
              };
            });
      in
      {
        packages = {
          default = pkgs.zellij;
          inherit zjstatus-wasm;
        };

        formatter = pkgs.nixfmt-rfc-style;

        checks = {
          # Verify that lib.nix evaluates and exports the expected attributes.
          lib-eval =
            let
              zLib = import ./lib.nix;
              assertions = [
                (builtins.isString zLib.topBar)
                (builtins.isString zLib.bottomBar)
              ];
            in
            assert builtins.all (x: x) assertions;
            pkgs.runCommand "lib-eval-check" { } "touch $out";

          # Verify that the formatter has been applied (no diff produced).
          formatting =
            pkgs.runCommand "formatting-check"
              {
                nativeBuildInputs = [ pkgs.nixfmt-rfc-style ];
              }
              ''
                nixfmt --check ${./flake.nix} ${./lib.nix} ${./module.nix} \
                  ${./modules/home-manager/common/zellij.nix}
                touch $out
              '';
        };
      }
    )
    // {
      homeManagerModules = {
        default = ./module.nix;
        zellij-vivid-rounded = ./module.nix;
        zellij-extended = ./modules/home-manager/common/zellij.nix;
      };

      lib = import ./lib.nix;

      overlays.default = final: prev: {
        zjstatus-wasm = self.packages.${final.stdenv.hostPlatform.system}.zjstatus-wasm;
      };
    };
}
