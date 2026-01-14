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
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        zjstatus-wasm = pkgs.fetchurl {
          url = "https://github.com/dj95/zjstatus/releases/download/v0.17.0/zjstatus.wasm";
          sha256 = "1rbvazam9qdj2z21fgzjvbyp5mcrxw28nprqsdzal4dqbm5dy112";
        };
      in
      {
        packages = {
          default = pkgs.zellij;
          inherit zjstatus-wasm;
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
