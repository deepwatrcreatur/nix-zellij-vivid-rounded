{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.programs.zellij-vivid-rounded;
  baseModule = import ./modules/home-manager/common/base.nix {
    name = "zellij-vivid-rounded";
    description = "Zellij with vivid colors, rounded tabs, and Ctrl-Alt keybindings";
    defaultEscToNormal = false;
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

  options.programs.zellij-vivid-rounded = {
    copyOnSelect = mkOption {
      type = types.bool;
      default = true;
      description = "Automatically copy text to the clipboard on selection.";
    };

    copyClipboard = mkOption {
      type = types.enum [
        "system"
        "primary"
      ];
      default = "system";
      description = "Which clipboard to use when copying on selection.";
    };

    keybindingStrategy = mkOption {
      type = types.enum [
        "standard"
        "ctrl-alt"
      ];
      default = "ctrl-alt";
      description = ''
        Which keybinding strategy to use.
        `standard`: Default Zellij keybindings (Ctrl-p, Ctrl-t, etc.)
        `ctrl-alt`: Overrides most Ctrl-based bindings with Ctrl-Alt to avoid TUI conflicts.
      '';
    };

    roundedCorners = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to use rounded corners for pane frames.";
    };
  };

  config = mkIf cfg.enable {
    programs.zellij.settings = {
      copy_on_select = cfg.copyOnSelect;
      copy_clipboard = cfg.copyClipboard;

      ui = {
        pane_frames = {
          rounded_corners = cfg.roundedCorners;
        };
      };

      keybinds = mkIf (cfg.keybindingStrategy == "standard") (mkForce { });
    };
  };
}
