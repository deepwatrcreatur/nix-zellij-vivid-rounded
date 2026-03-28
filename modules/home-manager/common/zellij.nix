{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.programs.zellij-extended;
  # Fetch zjstatus wasm directly since it's not in nixpkgs
  zjstatus-wasm =
    pkgs.zjstatus-wasm or (pkgs.fetchurl {
      url = "https://github.com/dj95/zjstatus/releases/download/v0.17.0/zjstatus.wasm";
      sha256 = "1rbvazam9qdj2z21fgzjvbyp5mcrxw28nprqsdzal4dqbm5dy112";
    });
in
{
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
        # Using darker backgrounds as requested
        themes.catppuccin-mocha = {
          bg = "#585b70"; # Surface2
          fg = "#cdd6f4"; # Text
          red = "#f38ba8";
          green = "#a6e3a1";
          blue = "#89b4fa";
          yellow = "#f9e2af";
          magenta = "#cba6f7"; # Mauve
          orange = "#fab387"; # Peach
          cyan = "#89dceb"; # Sky
          black = "#181825"; # Mantle (Darker Background)
          white = "#cdd6f4"; # Text
        };

        keybinds = {
          # Normal mode keybindings
          normal = {
            # Unbind default Ctrl keybindings to allow TUI apps to use them
            "unbind \"Ctrl t\"" = { };
            "unbind \"Ctrl p\"" = { };
            "unbind \"Ctrl s\"" = { };
            "unbind \"Ctrl n\"" = { };
            "unbind \"Ctrl h\"" = { };
            "unbind \"Ctrl j\"" = { };
            "unbind \"Ctrl k\"" = { };
            "unbind \"Ctrl l\"" = { };
            "unbind \"Ctrl o\"" = { };
            "unbind \"Ctrl q\"" = { };
            "unbind \"Ctrl g\"" = { };
            "unbind \"Ctrl b\"" = { };

            # Tab management (Ctrl-Alt)
            "bind \"Ctrl Alt t\"" = {
              SwitchToMode = "Tab";
            };
            "bind \"Ctrl Alt c\"" = {
              NewTab = { };
            };
            "bind \"Ctrl Alt x\"" = {
              CloseTab = { };
            };
            "bind \"Ctrl Alt [\"" = {
              GoToPreviousTab = { };
            };
            "bind \"Ctrl Alt ]\"" = {
              GoToNextTab = { };
            };
            "bind \"Ctrl Alt 1\"" = {
              GoToTab = 1;
            };
            "bind \"Ctrl Alt 2\"" = {
              GoToTab = 2;
            };
            "bind \"Ctrl Alt 3\"" = {
              GoToTab = 3;
            };
            "bind \"Ctrl Alt 4\"" = {
              GoToTab = 4;
            };
            "bind \"Ctrl Alt 5\"" = {
              GoToTab = 5;
            };
            "bind \"Ctrl Alt 6\"" = {
              GoToTab = 6;
            };
            "bind \"Ctrl Alt 7\"" = {
              GoToTab = 7;
            };
            "bind \"Ctrl Alt 8\"" = {
              GoToTab = 8;
            };
            "bind \"Ctrl Alt 9\"" = {
              GoToTab = 9;
            };

            # Pane management (Ctrl-Alt)
            "bind \"Ctrl Alt p\"" = {
              SwitchToMode = "Pane";
            };
            "bind \"Ctrl Alt s\"" = {
              NewPane = "Down";
            };
            "bind \"Ctrl Alt v\"" = {
              NewPane = "Right";
            };
            "bind \"Ctrl Alt h\"" = {
              MoveFocus = "Left";
            };
            "bind \"Ctrl Alt j\"" = {
              MoveFocus = "Down";
            };
            "bind \"Ctrl Alt k\"" = {
              MoveFocus = "Up";
            };
            "bind \"Ctrl Alt l\"" = {
              MoveFocus = "Right";
            };

            # Fullscreen
            "bind \"Ctrl Alt f\"" = {
              ToggleFocusFullscreen = { };
              SwitchToMode = "Normal";
            };
            "bind \"Ctrl Alt z\"" = {
              ToggleFocusFullscreen = { };
              SwitchToMode = "Normal";
            };

            # Back to normal mode
            "bind \"Esc\"" = {
              SwitchToMode = "Normal";
            };

            # Quit
            "bind \"Ctrl Alt q\"" = {
              Quit = { };
            };
          };

          # Pane mode keybindings
          pane = {
            "bind \"h\"" = {
              MoveFocus = "Left";
            };
            "bind \"j\"" = {
              MoveFocus = "Down";
            };
            "bind \"k\"" = {
              MoveFocus = "Up";
            };
            "bind \"l\"" = {
              MoveFocus = "Right";
            };
            "bind \"p\"" = {
              NewPane = "Left";
            };
            "bind \"n\"" = {
              NewPane = "Down";
            };
            "bind \"x\"" = {
              CloseFocus = { };
            };
            "bind \"f\"" = {
              ToggleFocusFullscreen = { };
              SwitchToMode = "Normal";
            };
            "bind \"z\"" = {
              ToggleFocusFullscreen = { };
              SwitchToMode = "Normal";
            };
            "bind \"Esc\"" = {
              SwitchToMode = "Normal";
            };
          };

          # Tab mode keybindings
          tab = {
            "bind \"h\"" = {
              GoToPreviousTab = { };
            };
            "bind \"l\"" = {
              GoToNextTab = { };
            };
            "bind \"1\"" = {
              GoToTab = 1;
            };
            "bind \"2\"" = {
              GoToTab = 2;
            };
            "bind \"3\"" = {
              GoToTab = 3;
            };
            "bind \"4\"" = {
              GoToTab = 4;
            };
            "bind \"5\"" = {
              GoToTab = 5;
            };
            "bind \"6\"" = {
              GoToTab = 6;
            };
            "bind \"7\"" = {
              GoToTab = 7;
            };
            "bind \"8\"" = {
              GoToTab = 8;
            };
            "bind \"9\"" = {
              GoToTab = 9;
            };
            "bind \"c\"" = {
              NewTab = { };
            };
            "bind \"x\"" = {
              CloseTab = { };
            };
            "bind \"r\"" = {
              SwitchToMode = "RenameTab";
            };
            "bind \"s\"" = {
              SwitchToMode = "Session";
            };
            "bind \"Esc\"" = {
              SwitchToMode = "Normal";
            };
          };

          # Resize mode keybindings
          resize = {
            "bind \"h\"" = {
              Resize = "Increase Left";
            };
            "bind \"j\"" = {
              Resize = "Increase Down";
            };
            "bind \"k\"" = {
              Resize = "Increase Up";
            };
            "bind \"l\"" = {
              Resize = "Increase Right";
            };
            "bind \"H\"" = {
              Resize = "Decrease Left";
            };
            "bind \"J\"" = {
              Resize = "Decrease Down";
            };
            "bind \"K\"" = {
              Resize = "Decrease Up";
            };
            "bind \"L\"" = {
              Resize = "Decrease Right";
            };
            "bind \"=\"" = {
              Resize = "Increase";
            };
            "bind \"-\"" = {
              Resize = "Decrease";
            };
          };

          # Search mode keybindings
          search = {
            "bind \"c\"" = {
              ScrollDown = { };
            };
            "bind \"C\"" = {
              ScrollUp = { };
            };
            "bind \"n\"" = {
              ScrollDown = { };
            };
            "bind \"N\"" = {
              ScrollUp = { };
            };
            "bind \"Esc\"" = {
              SwitchToMode = "Normal";
            };
          };

          # Session mode keybindings
          session = {
            "bind \"d\"" = {
              Detach = { };
            };
            "bind \"w\"" = {
              LaunchOrFocusPlugin = "zellij:session-manager";
              SwitchToMode = "Normal";
            };
            "bind \"Esc\"" = {
              SwitchToMode = "Normal";
            };
          };

          # Locked mode
          locked = {
            "bind \"Ctrl Alt Space\"" = {
              SwitchToMode = "Normal";
            };
          };
        };
      };
    };

    # Define an extended layout with rounded corners and vivid colors
    xdg.configFile."zellij/layouts/extended.kdl".text =
      let
        themeLib = import ../../../lib.nix;
      in
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
