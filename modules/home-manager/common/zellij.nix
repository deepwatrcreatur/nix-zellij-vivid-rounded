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

    userHostCommand = mkOption {
      type = types.str;
      default = "sh -c 'echo $USER@$(hostname -s 2>/dev/null || hostname)'";
      description = "Shell command whose stdout is shown as user@host in the top bar.";
    };

    memoryCommand = mkOption {
      type = types.str;
      default = "sh -c 'free -h 2>/dev/null | awk \"/^Mem:/{print \\$3 \\\"/\\\" \\$2; ok=1} END{if(!ok) exit 1}\" || echo N/A'";
      description = "Shell command whose stdout is shown as memory usage in the bottom bar.";
    };
  };

  config = mkIf cfg.enable {
    programs.zellij = {

      enable = true;

      settings = {

        theme = cfg.theme;

        show_startup_tips = cfg.showStartupTips;

        default_layout = cfg.layout;

        # Define Catppuccin Mocha theme locally to ensure it's available
        themes.catppuccin-mocha = themeLib.catppuccinMochaTheme;

        keybinds = themeLib.modalKeybinds // {
          # Esc → Normal in normal mode (no pass-through to application).
          normal = themeLib.normalModeKeybinds // {
            "bind \"Esc\"" = {
              SwitchToMode = "Normal";
            };
          };
        };
      };
    };

    # Define an extended layout with rounded corners and vivid colors
    xdg.configFile."zellij/layouts/extended.kdl".text = ''
      layout {
          pane size=1 borderless=true {
              plugin location="file:${zjstatus-wasm}" {
                  ${themeLib.mkTopBar { userHostCommand = cfg.userHostCommand; }}
              }
          }
          pane
          pane size=2 borderless=true {
              plugin location="file:${zjstatus-wasm}" {
                  ${themeLib.mkBottomBar { memoryCommand = cfg.memoryCommand; }}
              }
          }
      }
    '';
  };
}
