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
  options.programs.zellij-vivid-rounded = {
    enable = mkEnableOption "Zellij with vivid colors, rounded tabs, and Ctrl-Alt keybindings";
    showStartupTips = mkOption {
      type = types.bool;
      default = false;
      description = "Whether Zellij should show startup tips.";
    };
  };

  config = mkIf cfg.enable {
    programs.zellij = {

      enable = true;

      settings = {

        theme = "catppuccin-mocha";

        show_startup_tips = cfg.showStartupTips;

        default_layout = "extended";

        # Enable automatic copying to clipboard on text selection
        copy_on_select = true;
        copy_clipboard = "system";

        # Enable rounded corners for UI elements (tabs and pane frames)
        ui = {
          pane_frames = {
            rounded_corners = true;
          };
        };

        # Define Catppuccin Mocha theme locally to ensure it's available
        themes.catppuccin-mocha = themeLib.catppuccinMochaTheme;

        keybinds = themeLib.modalKeybinds // {
          # Esc is intentionally not bound in normal mode so it is passed
          # through to the running application.
          normal = themeLib.normalModeKeybinds;
        };
      };
    };

    # Define an extended layout with rounded corners and vivid colors

    xdg.configFile."zellij/layouts/extended.kdl".text =
      ''

        layout {

            pane size=1 borderless=true {

                plugin location="file:${zjstatus-wasm}" {

                    ${themeLib.topBar}

                }

            }

            pane

            pane size=2 borderless=true {

                plugin location="file:${zjstatus-wasm}" {

                    ${themeLib.bottomBar}

                }

            }

        }

      '';

  };
}
