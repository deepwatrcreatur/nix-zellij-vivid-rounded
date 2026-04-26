{
  config,
  lib,
  pkgs,
  ...
}:

let
  baseModule = import ./base.nix {
    name = "zellij-extended";
    description = "Zellij configuration with catppuccin theme and Ctrl-Alt keybindings";
    defaultEscToNormal = true;
  };
in
{
  meta.maintainers = [
    {
      name = "Anwer Khan";
      github = "deepwatrcreatur";
      email = "deepwatrcreatur@gmail.com";
    }
  ];

  imports = [ baseModule ];
}
