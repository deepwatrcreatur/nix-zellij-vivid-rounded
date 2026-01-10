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
  zjstatus-wasm = pkgs.fetchurl {
    url = "https://github.com/dj95/zjstatus/releases/download/v0.17.0/zjstatus.wasm";
    sha256 = "1rbvazam9qdj2z21fgzjvbyp5mcrxw28nprqsdzal4dqbm5dy112";
  };
in
{
  options.programs.zellij-extended = {
    enable = mkEnableOption "Zellij configuration with catppuccin theme and Ctrl-Alt keybindings";
  };

  config = mkIf cfg.enable {
    programs.zellij = {

      enable = true;

      settings = {

        theme = "catppuccin-mocha";

        show_startup_tips = false;

        default_layout = "extended";

        # Define Catppuccin Mocha theme locally to ensure it's available
        # Using darker backgrounds as requested
        themes.catppuccin-mocha = {
          bg = "#585b70";      # Surface2
          fg = "#cdd6f4";      # Text
          red = "#f38ba8";
          green = "#a6e3a1";
          blue = "#89b4fa";
          yellow = "#f9e2af";
          magenta = "#cba6f7"; # Mauve
          orange = "#fab387";  # Peach
          cyan = "#89dceb";    # Sky
          black = "#181825";   # Mantle (Darker Background)
          white = "#cdd6f4";   # Text
        };

        keybinds = {
          # Normal mode keybindings
          normal = {
            # Unbind default Ctrl keybindings to allow TUI apps to use them
            "unbind \"Ctrl t\"" = {};
            "unbind \"Ctrl p\"" = {};
            "unbind \"Ctrl s\"" = {};
            "unbind \"Ctrl n\"" = {};
            "unbind \"Ctrl h\"" = {};
            "unbind \"Ctrl j\"" = {};
            "unbind \"Ctrl k\"" = {};
            "unbind \"Ctrl l\"" = {};
            "unbind \"Ctrl o\"" = {};
            "unbind \"Ctrl q\"" = {};
            "unbind \"Ctrl g\"" = {};
            "unbind \"Ctrl b\"" = {};

            # Tab management (Ctrl-Alt)
            "bind \"Ctrl Alt t\"" = {
              SwitchToMode = "Tab";
            };
            "bind \"Ctrl Alt c\"" = {
              NewTab = {};
            };
            "bind \"Ctrl Alt x\"" = {
              CloseTab = {};
            };
            "bind \"Ctrl Alt [\"" = {
              GoToPreviousTab = {};
            };
            "bind \"Ctrl Alt ]\"" = {
              GoToNextTab = {};
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
              ToggleFocusFullscreen = {};
              SwitchToMode = "Normal";
            };
            "bind \"Ctrl Alt z\"" = {
              ToggleFocusFullscreen = {};
              SwitchToMode = "Normal";
            };

            # Back to normal mode
            "bind \"Esc\"" = {
              SwitchToMode = "Normal";
            };

            # Quit
            "bind \"Ctrl Alt q\"" = {
              Quit = {};
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
              CloseFocus = {};
            };
            "bind \"f\"" = {
              ToggleFocusFullscreen = {};
              SwitchToMode = "Normal";
            };
            "bind \"z\"" = {
              ToggleFocusFullscreen = {};
              SwitchToMode = "Normal";
            };
            "bind \"Esc\"" = {
              SwitchToMode = "Normal";
            };
          };

          # Tab mode keybindings
          tab = {
            "bind \"h\"" = {
              GoToPreviousTab = {};
            };
            "bind \"l\"" = {
              GoToNextTab = {};
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
              NewTab = {};
            };
            "bind \"x\"" = {
              CloseTab = {};
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
              ScrollDown = {};
            };
            "bind \"C\"" = {
              ScrollUp = {};
            };
            "bind \"n\"" = {
              ScrollDown = {};
            };
            "bind \"N\"" = {
              ScrollUp = {};
            };
            "bind \"Esc\"" = {
              SwitchToMode = "Normal";
            };
          };

          # Session mode keybindings
          session = {
            "bind \"d\"" = {
              Detach = {};
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
    xdg.configFile."zellij/layouts/extended.kdl".text = ''
      layout {
          pane size=1 borderless=true {
              plugin location="file:${zjstatus-wasm}" {
                  // Top bar: "Bubble" style with "double pills" for indicators
                  // Colors: Mantle (#181825) as bar bg, Surface0 (#313244) as module bg, Text (#cdd6f4)
                  
                  format_left   "#[fg=#89B4FA,bg=#181825]#[fg=#181825,bg=#89B4FA,bold]  #[fg=#89B4FA,bg=#313244]#[fg=#cdd6f4,bg=#313244,bold] {session} #[fg=#313244,bg=#181825] {tabs}"
                  format_right  "#[fg=#f9e2af,bg=#181825]#[fg=#181825,bg=#f9e2af,bold] 󰃭 #[fg=#f9e2af,bg=#313244]#[fg=#cdd6f4,bg=#313244,bold] {datetime} #[fg=#313244,bg=#181825]"
                  format_space  "#[bg=#181825]"

                  border_enabled  "false"

                  // Tabs: Vivid Green Pill for active, subtle for normal
                  tab_normal   "#[fg=#6C7086,bg=#181825] {index} {name} "
                  tab_active   "#[fg=#a6e3a1,bg=#181825]#[fg=#181825,bg=#a6e3a1,bold] {index} {name} #[fg=#a6e3a1,bg=#181825]"

                  datetime        "{format}"
                  datetime_format "%H:%M"
                  datetime_timezone "Europe/Berlin"
              }
          }
          pane
          pane size=2 borderless=true {
              plugin location="file:${zjstatus-wasm}" {
                  // Bottom bar
                  format_left   "{mode}"
                  format_center "#[fg=#6C7086,bg=#181825]Ctrl+Alt: [t]ab [p]ane [s]plit [v]ert [h/j/k/l]focus [f]ull [q]uit"
                  format_right  "#[fg=#cba6f7,bg=#181825]#[fg=#181825,bg=#cba6f7,bold]  #[fg=#cba6f7,bg=#313244]#[fg=#cdd6f4,bg=#313244,bold] {command_git_branch} #[fg=#313244,bg=#181825]"
                  format_space  "#[bg=#181825]"

                  // Modes: Vivid pills with bold text
                  mode_normal  "#[fg=#89B4FA,bg=#181825]#[fg=#181825,bg=#89B4FA,bold] NORMAL #[fg=#89B4FA,bg=#181825]"
                  mode_locked  "#[fg=#f38ba8,bg=#181825]#[fg=#181825,bg=#f38ba8,bold] LOCKED #[fg=#f38ba8,bg=#181825]"
                  mode_resize  "#[fg=#f9e2af,bg=#181825]#[fg=#181825,bg=#f9e2af,bold] RESIZE #[fg=#f9e2af,bg=#181825]"
                  mode_pane    "#[fg=#cba6f7,bg=#181825]#[fg=#181825,bg=#cba6f7,bold] PANE #[fg=#cba6f7,bg=#181825]"
                  mode_tab     "#[fg=#a6e3a1,bg=#181825]#[fg=#181825,bg=#a6e3a1,bold] TAB #[fg=#a6e3a1,bg=#181825]"
                  mode_scroll  "#[fg=#fab387,bg=#181825]#[fg=#181825,bg=#fab387,bold] SCROLL #[fg=#fab387,bg=#181825]"
                  mode_session "#[fg=#cba6f7,bg=#181825]#[fg=#181825,bg=#cba6f7,bold] SESSION #[fg=#cba6f7,bg=#181825]"

                  // Git branch
                  command_git_branch_command     "bash -c 'if git rev-parse --git-dir >/dev/null 2>&1; then git rev-parse --abbrev-ref HEAD 2>/dev/null || echo \"detached\"; else echo \"no-repo\"; fi'"
                  command_git_branch_format      "{stdout}"
                  command_git_branch_interval    "5"
                  command_git_branch_rendermode  "static"
              }
          }
      }
    '';
  };
}