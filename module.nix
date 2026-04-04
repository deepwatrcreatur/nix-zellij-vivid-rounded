{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.programs.zellij-vivid-rounded;
  # Fetch zjstatus wasm directly since it's not in nixpkgs
  zjstatus-wasm =
    pkgs.zjstatus-wasm or (pkgs.fetchurl {
      url = "https://github.com/dj95/zjstatus/releases/download/v0.17.0/zjstatus.wasm";
      sha256 = "1rbvazam9qdj2z21fgzjvbyp5mcrxw28nprqsdzal4dqbm5dy112";
    });
  themeLib = import ./lib.nix;
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

    roundedCorners = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to use rounded corners for pane frames.";
    };

    userHostCommand = mkOption {
      type = types.str;
      default = "sh -c 'echo $USER@$(hostname)'";
      description = "Shell command whose stdout is shown as user@host in the top bar.";
    };

    memoryCommand = mkOption {
      type = types.str;
      default = "bash -c 'free -h | grep Mem | awk \"{print \\$3 \\\"/\\\" \\$2}\" '";
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

        copy_on_select = cfg.copyOnSelect;
        copy_clipboard = cfg.copyClipboard;

        ui = {
          pane_frames = {
            rounded_corners = cfg.roundedCorners;
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
