{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.programs.zellij-extended;
  themeLib = import ../../../lib.nix;
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

  options.programs.zellij-extended = {
    enable = mkEnableOption "Zellij configuration with catppuccin theme and Ctrl-Alt keybindings";
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

        # Define Catppuccin Mocha theme locally to ensure it's available
        themes.catppuccin-mocha = themeLib.catppuccinMochaTheme;

        keybinds = themeLib.modalKeybinds // {
          # Esc → Normal in normal mode (no pass-through to application).
          normal = themeLib.normalModeKeybinds // {
            "bind \"Esc\"" = { SwitchToMode = "Normal"; };
          };
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
