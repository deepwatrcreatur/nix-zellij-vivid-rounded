{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.zellij-vivid-rounded;
  # Fetch zjstatus wasm directly since it's not in nixpkgs
  zjstatus-wasm = pkgs.fetchurl {
    url = "https://github.com/dj95/zjstatus/releases/download/v0.17.0/zjstatus.wasm";
    sha256 = "1rbvazam9qdj2z21fgzjvbyp5mcrxw28nprqsdzal4dqbm5dy112";
  };
in {
  options.programs.zellij-vivid-rounded = {
    enable = mkEnableOption "Zellij with vivid colors, rounded tabs, and Ctrl-Alt keybindings";
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
            "bind \"Ctrl Alt t\"" = { SwitchToMode = "Tab"; };
            "bind \"Ctrl Alt c\"" = { NewTab = {}; };
            "bind \"Ctrl Alt x\"" = { CloseTab = {}; };
            "bind \"Ctrl Alt [\"" = { GoToPreviousTab = {}; };
            "bind \"Ctrl Alt ]\"" = { GoToNextTab = {}; };
            "bind \"Ctrl Alt 1\"" = { GoToTab = 1; };
            "bind \"Ctrl Alt 2\"" = { GoToTab = 2; };
            "bind \"Ctrl Alt 3\"" = { GoToTab = 3; };
            "bind \"Ctrl Alt 4\"" = { GoToTab = 4; };
            "bind \"Ctrl Alt 5\"" = { GoToTab = 5; };
            "bind \"Ctrl Alt 6\"" = { GoToTab = 6; };
            "bind \"Ctrl Alt 7\"" = { GoToTab = 7; };
            "bind \"Ctrl Alt 8\"" = { GoToTab = 8; };
            "bind \"Ctrl Alt 9\"" = { GoToTab = 9; };

            # Pane management (Ctrl-Alt)
            "bind \"Ctrl Alt p\"" = { SwitchToMode = "Pane"; };
            "bind \"Ctrl Alt s\"" = { NewPane = "Down"; };
            "bind \"Ctrl Alt v\"" = { NewPane = "Right"; };
            "bind \"Ctrl Alt h\"" = { MoveFocus = "Left"; };
            "bind \"Ctrl Alt j\"" = { MoveFocus = "Down"; };
            "bind \"Ctrl Alt k\"" = { MoveFocus = "Up"; };
            "bind \"Ctrl Alt l\"" = { MoveFocus = "Right"; };

            # Fullscreen
            "bind \"Ctrl Alt f\"" = { ToggleFocusFullscreen = {}; SwitchToMode = "Normal"; };
            "bind \"Ctrl Alt z\"" = { ToggleFocusFullscreen = {}; SwitchToMode = "Normal"; };

            # Back to normal mode
            "bind \"Esc\"" = { SwitchToMode = "Normal"; };

            # Quit
            "bind \"Ctrl Alt q\"" = { Quit = {}; };
          };

          # Pane mode keybindings
          pane = {
            "bind \"h\"" = { MoveFocus = "Left"; };
            "bind \"j\"" = { MoveFocus = "Down"; };
            "bind \"k\"" = { MoveFocus = "Up"; };
            "bind \"l\"" = { MoveFocus = "Right"; };
            "bind \"p\"" = { NewPane = "Left"; };
            "bind \"n\"" = { NewPane = "Down"; };
            "bind \"x\"" = { CloseFocus = {}; };
            "bind \"f\"" = { ToggleFocusFullscreen = {}; SwitchToMode = "Normal"; };
            "bind \"z\"" = { ToggleFocusFullscreen = {}; SwitchToMode = "Normal"; };
            "bind \"Esc\"" = { SwitchToMode = "Normal"; };
          };

          # Tab mode keybindings
          tab = {
            "bind \"h\"" = { GoToPreviousTab = {}; };
            "bind \"l\"" = { GoToNextTab = {}; };
            "bind \"1\"" = { GoToTab = 1; };
            "bind \"2\"" = { GoToTab = 2; };
            "bind \"3\"" = { GoToTab = 3; };
            "bind \"4\"" = { GoToTab = 4; };
            "bind \"5\"" = { GoToTab = 5; };
            "bind \"6\"" = { GoToTab = 6; };
            "bind \"7\"" = { GoToTab = 7; };
            "bind \"8\"" = { GoToTab = 8; };
            "bind \"9\"" = { GoToTab = 9; };
            "bind \"c\"" = { NewTab = {}; };
            "bind \"x\"" = { CloseTab = {}; };
            "bind \"r\"" = { SwitchToMode = "RenameTab"; };
            "bind \"s\"" = { SwitchToMode = "Session"; };
            "bind \"Esc\"" = { SwitchToMode = "Normal"; };
          };

          # Resize mode keybindings
          resize = {
            "bind \"h\"" = { Resize = "Increase Left"; };
            "bind \"j\"" = { Resize = "Increase Down"; };
            "bind \"k\"" = { Resize = "Increase Up"; };
            "bind \"l\"" = { Resize = "Increase Right"; };
            "bind \"H\"" = { Resize = "Decrease Left"; };
            "bind \"J\"" = { Resize = "Decrease Down"; };
            "bind \"K\"" = { Resize = "Decrease Up"; };
            "bind \"L\"" = { Resize = "Decrease Right"; };
            "bind \"=\"" = { Resize = "Increase"; };
            "bind \"-\"" = { Resize = "Decrease"; };
          };

          # Search mode keybindings
          search = {
            "bind \"c\"" = { ScrollDown = {}; };
            "bind \"C\"" = { ScrollUp = {}; };
            "bind \"n\"" = { ScrollDown = {}; };
            "bind \"N\"" = { ScrollUp = {}; };
            "bind \"Esc\"" = { SwitchToMode = "Normal"; };
          };

          # Session mode keybindings
          session = {
            "bind \"d\"" = { Detach = {}; };
            "bind \"w\"" = {
              LaunchOrFocusPlugin = "zellij:session-manager";
              SwitchToMode = "Normal";
            };
            "bind \"Esc\"" = { SwitchToMode = "Normal"; };
          };

          # Locked mode
          locked = {
            "bind \"Ctrl Alt Space\"" = { SwitchToMode = "Normal"; };
          };
        };
      };
    };

    # Define an extended layout with rounded corners and vivid colors
    xdg.configFile."zellij/layouts/extended.kdl".text = ''
      layout {
          pane size=1 borderless=true {
              plugin location="file:${zjstatus-wasm}" {
                  // Top bar: rounded icons with accent colors
                  // Terminal icon: green rounded pill with half-circle edges
                  format_left   "#[bg=#313244,fg=#a6e3a1,bold]◐#[bg=#a6e3a1,fg=#1e1e2e,bold]🖥#[bg=#313244,fg=#cdd6f4]◑ {session} #[fg=#6C7086]{tabs}"
                  // OS icon: yellow rounded pill with half-circle edges
                  format_right  "#[bg=#313244,fg=#f9e2af,bold]◐#[bg=#f9e2af,fg=#1e1e2e,bold]{command_os_symbol}#[bg=#313244,fg=#cdd6f4]◑ {command_user_host} #[fg=#9ca3af]{command_memory}"

                  format_space  ""

                  border_enabled  "false"

                  // Refined tab styling: vivid color ONLY on the number pill
                  // Inactive tabs: gray text, subtle and muted
                  tab_normal   "#[fg=#6C7086] {index} #[fg=#6C7086]{name} "
                  // Active tabs: number in small purple pill, name in subtle background
                  // Dark caps + bright purple pill on just the index + reset to subtle background + name
                  tab_active   "#[bg=#313244,fg=#cba6f7,bold] #[bg=#cba6f7,fg=#1e1e2e,bold]{index}#[bg=#313244,fg=#cdd6f4] {name} "

                  command_os_symbol_command     "uname -s | sed 's/Linux/󰌽/; s/Darwin/󰀵/; s/NixOS/󱄅/'"
                  command_os_symbol_format      "{stdout}"
                  command_os_symbol_interval    "60"
                  command_os_symbol_rendermode  "static"

                  command_user_host_command     "sh -c 'echo $USER@$(hostname)'"
                  command_user_host_format      "{stdout}"
                  command_user_host_interval    "60"
                  command_user_host_rendermode  "static"

                  command_memory_command        "free -h | awk 'NR==2 {print $3 \" / \" $2}' | sed 's/Gi/G/g'"
                  command_memory_format         "{stdout}"
                  command_memory_interval       "5"
                  command_memory_rendermode     "static"
              }
          }
          pane
          pane size=2 borderless=true {
              plugin location="file:${zjstatus-wasm}" {
                  // Bottom bar: asymmetrical rounded accents - pill right of mode, pill left of branch
                  // Mode indicator: subtle text on left, light blue rounded pill on right
                  format_left   "#[bg=#313244,fg=#cdd6f4] {mode} #[bg=#313244,fg=#89B4FA,bold]◐#[bg=#89B4FA,fg=#1e1e2e,bold]◑#[bg=#1e1e2e,fg=#89B4FA] "
                  format_center "#[fg=#6C7086,bold]Ctrl+Alt: [t]ab [p]ane [s]plit [v]ert [h/j/k/l]focus [f]ull [q]uit"
                  // Git branch: purple rounded pill on left, subtle text on right
                  format_right  "#[bg=#313244,fg=#cba6f7,bold]◐#[bg=#cba6f7,fg=#1e1e2e,bold]󰊢#[bg=#313244,fg=#cdd6f4]◑ {command_git_branch} "
                  format_space  ""

                  // Mode indicators - simple text, displayed in the light blue pill from format_left
                  mode_normal  "NORMAL"
                  mode_locked  "LOCKED"
                  mode_resize  "RESIZE"
                  mode_pane    "PANE"
                  mode_tab     "TAB"
                  mode_scroll  "SCROLL"
                  mode_session "SESSION"

                  command_git_branch_command     "git rev-parse --abbrev-ref HEAD"
                  command_git_branch_format      "{stdout}"
                  command_git_branch_interval    "10"
                  command_git_branch_rendermode  "static"
              }
          }
      }
    '';
  };
}
