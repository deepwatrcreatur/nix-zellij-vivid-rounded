{
  description = "Zellij terminal multiplexer with vivid colors, rounded tabs, and Ctrl-Alt keybindings";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages.default = pkgs.hello;
      }
    ) // {
      homeManagerModules.default = ./module.nix;

      lib = import ./lib.nix;

      # Optional: overlay for custom packages
      overlays.default = final: prev: {
        zellij-vivid-rounded = ./module.nix;
      };
    };
}
