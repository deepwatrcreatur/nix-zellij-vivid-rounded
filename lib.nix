{
  # ---------------------------------------------------------------------------
  # KDL configuration for the Top Bar (Tabs, Session, User@Host)
  # ---------------------------------------------------------------------------
  topBar = ''
    // Top bar: Seamless "Double Pill" style

    format_left   "#[fg=#89B4FA,bg=#181825]#[fg=#181825,bg=#89B4FA,bold]  #[fg=#cdd6f4,bg=#313244,bold] {session} #[fg=#313244,bg=#181825] {tabs}"
    format_right  "#[fg=#f9e2af,bg=#181825]#[fg=#181825,bg=#f9e2af,bold] 󰃭 #[fg=#cdd6f4,bg=#313244,bold] {command_user_host} #[fg=#313244,bg=#181825]"
    format_space  "#[bg=#181825]"
    format_hide_on_overlength "true"
    format_precedence "lrc"

    border_enabled  "false"

    // Tabs: Accented Index + Name. Active gets brighter background.
    // Normal: Green Index, Surface0 Name
    tab_normal   "#[fg=#a6e3a1,bg=#181825]#[fg=#181825,bg=#a6e3a1,bold] {index} #[fg=#cdd6f4,bg=#313244] {name} #[fg=#313244,bg=#181825] "
    // Active: Green Index, Surface2 (Brighter) Name
    tab_active   "#[fg=#a6e3a1,bg=#181825]#[fg=#181825,bg=#a6e3a1,bold] {index} #[fg=#cdd6f4,bg=#585b70,bold] {name} #[fg=#585b70,bg=#181825,bold] "

    // $USER and hostname(1) are POSIX/widely available on Linux, macOS, and BSD.
    command_user_host_command     "sh -c 'echo $USER@$(hostname -s 2>/dev/null || hostname)'"
    command_user_host_format      "{stdout}"
    command_user_host_interval    "60"
    command_user_host_rendermode  "static"
  '';

  # ---------------------------------------------------------------------------
  # KDL configuration for the Bottom Bar (Modes, Hints, Memory)
  # ---------------------------------------------------------------------------
  bottomBar = ''
    // Bottom bar
    format_left   "{mode}"
    format_center "#[fg=#6C7086,bg=#181825]Ctrl+Alt: [t]ab [p]ane [s]plit [v]ert [h/j/k/l]focus [f]ull [q]uit"
    format_right  "#[fg=#cba6f7,bg=#181825]#[fg=#181825,bg=#cba6f7,bold] 󰍛 #[fg=#cdd6f4,bg=#313244,bold] {command_memory} #[fg=#313244,bg=#181825]"
    format_space  "#[bg=#181825]"
    format_hide_on_overlength "true"
    format_precedence "lrc"

    border_enabled  "false"

    // Modes: Flat left edge, rounded right edge
    mode_normal  "#[fg=#181825,bg=#89B4FA,bold] NORMAL #[fg=#89B4FA,bg=#181825]"
    mode_locked  "#[fg=#181825,bg=#f38ba8,bold] LOCKED #[fg=#f38ba8,bg=#181825]"
    mode_resize  "#[fg=#181825,bg=#f9e2af,bold] RESIZE #[fg=#f9e2af,bg=#181825]"
    mode_pane    "#[fg=#181825,bg=#cba6f7,bold] PANE #[fg=#cba6f7,bg=#181825]"
    mode_tab     "#[fg=#181825,bg=#a6e3a1,bold] TAB #[fg=#a6e3a1,bg=#181825]"
    mode_scroll  "#[fg=#181825,bg=#fab387,bold] SCROLL #[fg=#fab387,bg=#181825]"
    mode_session "#[fg=#181825,bg=#cba6f7,bold] SESSION #[fg=#cba6f7,bg=#181825]"

    // Memory Usage
    // free(1) is Linux-specific; the command falls back to "N/A" on other systems.
    // Override memoryCommand in the module option to use vm_stat(1) on macOS or
    // any other host-specific tool.
    command_memory_command     "sh -c 'free -h 2>/dev/null | awk \"/^Mem:/{print \\$3 \\\"/\\\" \\$2}\" || echo N/A'"
    command_memory_format      "{stdout}"
    command_memory_interval    "5"
    command_memory_rendermode  "static"
  '';

  # ---------------------------------------------------------------------------
  # Shared Nix helpers used by both HM modules
  # ---------------------------------------------------------------------------

  # Fetch zjstatus wasm; falls back to pkgs.zjstatus-wasm when packaged.
  mkZjstatusWasm = pkgs:
    pkgs.zjstatus-wasm or (pkgs.fetchurl {
      url = "https://github.com/dj95/zjstatus/releases/download/v0.17.0/zjstatus.wasm";
      sha256 = "1rbvazam9qdj2z21fgzjvbyp5mcrxw28nprqsdzal4dqbm5dy112";
    });

  # Catppuccin Mocha colour palette used in theme and status bars.
  catppuccinMochaTheme = {
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

  # Shared normal-mode bindings without an Esc binding so that Esc is passed
  # through to the running application (the default for zellij-vivid-rounded).
  # Modules that want Esc → Normal can merge in their own binding on top.
  normalModeKeybinds = {
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
    "bind \"Ctrl Alt t\"" = { SwitchToMode = "Tab"; };
    "bind \"Ctrl Alt c\"" = { NewTab = { }; };
    "bind \"Ctrl Alt x\"" = { CloseTab = { }; };
    "bind \"Ctrl Alt [\"" = { GoToPreviousTab = { }; };
    "bind \"Ctrl Alt ]\"" = { GoToNextTab = { }; };
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
    "bind \"Ctrl Alt f\"" = {
      ToggleFocusFullscreen = { };
      SwitchToMode = "Normal";
    };
    "bind \"Ctrl Alt z\"" = {
      ToggleFocusFullscreen = { };
      SwitchToMode = "Normal";
    };

    # Quit
    "bind \"Ctrl Alt q\"" = { Quit = { }; };
  };

  # Keybinds for all modes other than normal.
  modalKeybinds = {
    pane = {
      "bind \"h\"" = { MoveFocus = "Left"; };
      "bind \"j\"" = { MoveFocus = "Down"; };
      "bind \"k\"" = { MoveFocus = "Up"; };
      "bind \"l\"" = { MoveFocus = "Right"; };
      "bind \"p\"" = { NewPane = "Left"; };
      "bind \"n\"" = { NewPane = "Down"; };
      "bind \"x\"" = { CloseFocus = { }; };
      "bind \"f\"" = {
        ToggleFocusFullscreen = { };
        SwitchToMode = "Normal";
      };
      "bind \"z\"" = {
        ToggleFocusFullscreen = { };
        SwitchToMode = "Normal";
      };
      "bind \"Esc\"" = { SwitchToMode = "Normal"; };
    };

    tab = {
      "bind \"h\"" = { GoToPreviousTab = { }; };
      "bind \"l\"" = { GoToNextTab = { }; };
      "bind \"1\"" = { GoToTab = 1; };
      "bind \"2\"" = { GoToTab = 2; };
      "bind \"3\"" = { GoToTab = 3; };
      "bind \"4\"" = { GoToTab = 4; };
      "bind \"5\"" = { GoToTab = 5; };
      "bind \"6\"" = { GoToTab = 6; };
      "bind \"7\"" = { GoToTab = 7; };
      "bind \"8\"" = { GoToTab = 8; };
      "bind \"9\"" = { GoToTab = 9; };
      "bind \"c\"" = { NewTab = { }; };
      "bind \"x\"" = { CloseTab = { }; };
      "bind \"r\"" = { SwitchToMode = "RenameTab"; };
      "bind \"s\"" = { SwitchToMode = "Session"; };
      "bind \"Esc\"" = { SwitchToMode = "Normal"; };
    };

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

    search = {
      "bind \"c\"" = { ScrollDown = { }; };
      "bind \"C\"" = { ScrollUp = { }; };
      "bind \"n\"" = { ScrollDown = { }; };
      "bind \"N\"" = { ScrollUp = { }; };
      "bind \"Esc\"" = { SwitchToMode = "Normal"; };
    };

    session = {
      "bind \"d\"" = { Detach = { }; };
      "bind \"w\"" = {
        LaunchOrFocusPlugin = "zellij:session-manager";
        SwitchToMode = "Normal";
      };
      "bind \"Esc\"" = { SwitchToMode = "Normal"; };
    };

    locked = {
      "bind \"Ctrl Alt Space\"" = { SwitchToMode = "Normal"; };
    };
  };
}
