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
  zjstatus-wasm = pkgs.fetchurl {
    url = "https://github.com/dj95/zjstatus/releases/download/v0.17.0/zjstatus.wasm";
    sha256 = "1rbvazam9qdj2z21fgzjvbyp5mcrxw28nprqsdzal4dqbm5dy112";
  };
in
{
  options.programs.zellij-vivid-rounded = {
    enable = mkEnableOption "Zellij with vivid colors, rounded tabs, and Ctrl-Alt keybindings";

    accentColor = mkOption {
      type = types.str;
      default = "#89B4FA";
      description = "Primary accent color for UI elements (hex color)";
    };

    accentColor2 = mkOption {
      type = types.str;
      default = "#89dceb";
      description = "Secondary accent color for UI elements (hex color)";
    };

    accentColor3 = mkOption {
      type = types.str;
      default = "#cba6f7";
      description = "Tertiary accent color for UI elements (hex color)";
    };

    boxBackground = mkOption {
      type = types.str;
      default = "#313244";
      description = "Background color for highlighted text boxes (hex color)";
    };

    modeBackground = mkOption {
      type = types.str;
      default = "#313244";
      description = "Background color for mode indicator boxes (hex color)";
    };

    barBackground = mkOption {
      type = types.str;
      default = "#000000";
      description = "Background color for top and bottom bars (hex color). Use black for vivid accent contrast, or set to match your terminal background.";
    };

    subtleHighlight = mkOption {
      type = types.str;
      default = "#6C7086";
      description = "Color for subtle left-side highlights (hex color)";
    };
  };

  config = mkIf cfg.enable {
    programs.zellij = {

      enable = true;

      settings = {

        theme = "catppuccin-mocha";

        show_startup_tips = false;

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
        themes.catppuccin-mocha = {
          bg = "#585b70";
          fg = "#cdd6f4";
          red = "#f38ba8";
          green = "#a6e3a1";
          blue = "#89b4fa";
          yellow = "#f9e2af";
          magenta = "#cba6f7";
          orange = "#fab387";
          cyan = "#89dceb";
          black = "#181825";
          white = "#cdd6f4";
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

    # Define an extended layout with vivid rounded accents and subtle highlights
    xdg.configFile."zellij/layouts/extended.kdl".text = ''
      layout {
          pane size=1 borderless=true {
              plugin location="file:${zjstatus-wasm}" {
                  // Top bar with black background for contrast with vivid accents
                  format_left   "#[bg=${cfg.barBackground},fg=${cfg.subtleHighlight}] {session} #[fg=${cfg.subtleHighlight}]{tabs}"
                  format_right  "#[fg=${cfg.accentColor2},bg=${cfg.barBackground}] {command_user_host} "
                  format_space  ""

                  border_enabled  "false"

                  // Tab styling: subtle left (index number), vivid right with rounded corner effect
                  // Inactive tabs with subtle coloring
                  tab_normal   "#[bg=${cfg.barBackground},fg=${cfg.subtleHighlight}] {index} {name} "
                  // Active tabs: subtle left with index, then vivid color on right (rounded corner effect)
                  tab_active   "#[bg=${cfg.barBackground},fg=${cfg.subtleHighlight}]{index}#[fg=#a6e3a1,bg=${cfg.barBackground}]#[fg=#a6e3a1] {name} "

                  command_user_host_command     "sh -c 'echo $USER@$(hostname)'"
                  command_user_host_format      "{stdout}"
                  command_user_host_interval    "60"
                  command_user_host_rendermode  "static"
              }
          }
          pane
          pane size=2 borderless=true {
              plugin location="file:${zjstatus-wasm}" {
                  // Bottom bar with black background and subtle/vivid indicators
                  format_left   "{mode}"
                  format_center "#[fg=${cfg.subtleHighlight},bg=${cfg.barBackground}]Ctrl+Alt: [t]ab [p]ane [s]plit [v]ert [h/j/k/l]focus [f]ull [q]uit"
                  format_right  "#[bg=${cfg.barBackground},fg=${cfg.subtleHighlight}]{command_memory} "
                  format_space  ""

                  // Mode indicators with subtle left side, vivid right side for rounded corner effect
                  mode_normal  "#[bg=${cfg.barBackground},fg=${cfg.subtleHighlight}] #[fg=${cfg.accentColor},bg=${cfg.barBackground}]NORMAL "
                  mode_locked  "#[bg=${cfg.barBackground},fg=${cfg.subtleHighlight}] #[fg=#f38ba8,bg=${cfg.barBackground}]LOCKED "
                  mode_resize  "#[bg=${cfg.barBackground},fg=${cfg.subtleHighlight}] #[fg=#f9e2af,bg=${cfg.barBackground}]RESIZE "
                  mode_pane    "#[bg=${cfg.barBackground},fg=${cfg.subtleHighlight}] #[fg=${cfg.accentColor3},bg=${cfg.barBackground}]PANE "
                  mode_tab     "#[bg=${cfg.barBackground},fg=${cfg.subtleHighlight}] #[fg=#a6e3a1,bg=${cfg.barBackground}]TAB "
                  mode_scroll  "#[bg=${cfg.barBackground},fg=${cfg.subtleHighlight}] #[fg=#fab387,bg=${cfg.barBackground}]SCROLL "
                  mode_session "#[bg=${cfg.barBackground},fg=${cfg.subtleHighlight}] #[fg=${cfg.accentColor3},bg=${cfg.barBackground}]SESSION "

                  // Show memory usage in bottom right (GB/GB format)
                  command_memory_command     "bash -c 'free -h | grep Mem | awk \"{gsub(/Gi/, \\\"GB\\\", \\$1); gsub(/Mi/, \\\"MB\\\", \\$1); print \\$3 \\\"/\\\" \\$2}\"'"
                  command_memory_format      "{stdout}"
                  command_memory_interval    "5"
                  command_memory_rendermode  "static"
              }
          }
      }
    '';
  };
}
