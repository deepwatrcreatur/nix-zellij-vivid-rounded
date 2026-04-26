{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.programs.zellij-vivid-rounded;
  themeLib = import ./lib.nix;
  zjstatus-wasm = themeLib.mkZjstatusWasm pkgs;
in
{
  meta.maintainers = [
    {
      name = "Anwer Khan";
      github = "deepwatrcreatur";
      email = "deepwatrcreatur@gmail.com";
    }
  ];

  options.programs.zellij-vivid-rounded = {
    enable = mkEnableOption "Zellij with vivid colors, rounded tabs, and Ctrl-Alt keybindings";

    showStartupTips = mkOption {
      type = types.bool;
      default = false;
      description = "Whether Zellij should show startup tips.";
    };

    theme = mkOption {
      type = types.str;
      default = "catppuccin-mocha";
      description = "Name of the Zellij theme to activate.";
    };

    layout = mkOption {
      type = types.str;
      default = "extended";
      description = "Name of the default Zellij layout.";
    };

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

    userHostCommand = mkOption {
      type = types.str;
      default = "sh -c 'echo $USER@$(hostname -s 2>/dev/null || hostname)'";
      description = "Shell command whose stdout is shown as user@host in the top bar.";
    };

    userHostInterval = mkOption {
      type = types.int;
      default = 60;
      description = "Refresh interval in seconds for the user@host command.";
    };

    memoryCommand = mkOption {
      type = types.str;
      default = "sh -c 'free -h 2>/dev/null | awk \"/^Mem:/{print \\$3 \\\"/\\\" \\$2; ok=1} END{if(!ok) exit 1}\" || echo N/A'";
      description = "Shell command whose stdout is shown as memory usage in the bottom bar.";
    };

    memoryInterval = mkOption {
      type = types.int;
      default = 5;
      description = "Refresh interval in seconds for the memory command.";
    };
  };

  config = mkIf cfg.enable {
    programs.zellij = {

      enable = true;

      settings = {

        theme = cfg.theme;

        show_startup_tips = cfg.showStartupTips;

        default_layout = cfg.layout;

        copy_on_select = cfg.copyOnSelect;
        copy_clipboard = cfg.copyClipboard;

        ui = {
          pane_frames = {
            rounded_corners = cfg.roundedCorners;
          };
        };

        # Define Catppuccin Mocha theme locally to ensure it's available
        themes.catppuccin-mocha = themeLib.catppuccinMochaTheme;

        keybinds = mkMerge [
          (mkIf (cfg.keybindingStrategy == "ctrl-alt") (themeLib.modalKeybinds // {
            normal = themeLib.ctrlAltNormalModeKeybinds;
          }))
          # If standard, we just use defaults (empty attrset here means no overrides)
          (mkIf (cfg.keybindingStrategy == "standard") { })
        ];
      };
    };

    # Define an extended layout with rounded corners and vivid colors
    xdg.configFile."zellij/layouts/extended.kdl".text = ''
      layout {
          pane size=1 borderless=true {
              plugin location="file:${zjstatus-wasm}" {
                  ${themeLib.mkTopBar {
                    userHostCommand = cfg.userHostCommand;
                    userHostInterval = toString cfg.userHostInterval;
                  }}
              }
          }
          pane
          pane size=2 borderless=true {
              plugin location="file:${zjstatus-wasm}" {
                  ${themeLib.mkBottomBar {
                    memoryCommand = cfg.memoryCommand;
                    memoryInterval = toString cfg.memoryInterval;
                  }}
              }
          }
      }
    '';

  };
}
