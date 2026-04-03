rec {
  # ---------------------------------------------------------------------------
  # Parameterized KDL generators for the status bars.
  # Pass overrides via the attrset argument; all fields have defaults.
  # ---------------------------------------------------------------------------

  mkTopBar =
    {
      # Shell command whose stdout is shown as "user@host" in the top-right.
      userHostCommand ? "sh -c 'echo $USER@$(hostname)'",
    }:
    ''
      // Top bar: Seamless "Double Pill" style

      format_left   "#[fg=#89B4FA,bg=#181825]#[fg=#181825,bg=#89B4FA,bold]  #[fg=#cdd6f4,bg=#313244,bold] {session} #[fg=#313244,bg=#181825] {tabs}"
      format_right  "#[fg=#f9e2af,bg=#181825]#[fg=#181825,bg=#f9e2af,bold] 󰃭 #[fg=#cdd6f4,bg=#313244,bold] {command_user_host} #[fg=#313244,bg=#181825]"
      format_space  "#[bg=#181825]"
      format_hide_on_overlength "true"
      format_precedence "lrc"

      border_enabled  "false"

      border_enabled  "false"

      // Tabs: Accented Index + Name. Active gets brighter background.
      // Normal: Green Index, Surface0 Name
      tab_normal   "#[fg=#a6e3a1,bg=#181825]#[fg=#181825,bg=#a6e3a1,bold] {index} #[fg=#cdd6f4,bg=#313244] {name} #[fg=#313244,bg=#181825] "
      // Active: Green Index, Surface2 (Brighter) Name
      tab_active   "#[fg=#a6e3a1,bg=#181825]#[fg=#181825,bg=#a6e3a1,bold] {index} #[fg=#cdd6f4,bg=#585b70,bold] {name} #[fg=#585b70,bg=#181825,bold] "

      command_user_host_command     "${userHostCommand}"
      command_user_host_format      "{stdout}"
      command_user_host_interval    "60"
      command_user_host_rendermode  "static"
    '';

  mkBottomBar =
    {
      # Shell command whose stdout is shown as memory usage in the bottom-right.
      memoryCommand ? "bash -c 'free -h | grep Mem | awk \"{print \\$3 \\\"/\\\" \\$2}\" '",
    }:
    ''
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
      command_memory_command     "${memoryCommand}"
      command_memory_format      "{stdout}"
      command_memory_interval    "5"
      command_memory_rendermode  "static"
    '';

  # ---------------------------------------------------------------------------
  # Convenience aliases using the default commands (backwards-compatible).
  # ---------------------------------------------------------------------------
  topBar = mkTopBar { };
  bottomBar = mkBottomBar { };
}
