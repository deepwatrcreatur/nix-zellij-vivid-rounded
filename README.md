# nix-zellij-vivid-rounded

A highly customized [Zellij](https://zellij.dev/) configuration for NixOS/home-manager featuring a "darker Catppuccin" aesthetic, seamless "double pill" indicators, and thoughtfully remapped keybindings.

![Zellij with vivid rounded tabs](./screenshot.png?v=1.0.0)

## Features

### Visual Design
- **Darker Catppuccin Mocha**: Uses the deeper `Mantle` color (`#181825`) as the primary background for high contrast.
- **Seamless "Double Pill" Aesthetic**:
  - **Top Bar**:
    - **Left**: Session indicator (Blue Icon -> Surface Text) + Tabs.
    - **Right**: User@Host indicator (Yellow Icon -> Surface Text).
  - **Bottom Bar**:
    - **Left**: Mode indicator (Vivid Color) - Flush left.
    - **Right**: Memory usage (Purple Icon -> Surface Text).
- **Tab Styling**:
  - **All Tabs**: Accented with a green index number.
  - **Active Tab**: Highlighted name background (Surface2) for clear visibility.
  - **Normal Tabs**: Subtle name background (Surface0).
- **Overflow Handling**: Prioritizes keeping tabs visible when window width is limited.

### Clipboard & Text Selection
- **Automatic copy-to-clipboard**: Text selection automatically copies to the system clipboard (`copy_on_select = true`, `copy_clipboard = "system"`). This is enabled only in the `zellij-vivid-rounded` module; the `zellij-extended` module does not set these options.
- Works reliably in **local terminals**
- **Over SSH**: requires the terminal emulator to support and forward [OSC 52](https://invisible-island.net/xterm/ctlseqs/ctlseqs.html#h3-Operating-System-Commands) escape sequences, and the SSH session must not suppress them. Tested working with WezTerm and Kitty. May not work with older terminals, `tmux` without `set-clipboard on`, or restricted SSH servers.
- **Wayland**: uses the system clipboard via the `system` backend; if your compositor doesn't expose a clipboard, try setting `copy_clipboard = "primary"` in your Zellij settings to use the X11 primary selection instead.
- If clipboard does not work in your environment, set `copy_on_select = false` in your Zellij settings and copy manually.

### Reusability (New in v1.0)
- **Shared Theme Library**: The `lib.nix` file exports the KDL configuration strings (`topBar`, `bottomBar`).
- **Easy Integration**: Use `inputs.zellij-vivid-rounded.lib` to apply the same theme to other Zellij layouts (like `yazelix`) in your configuration.

### Keybindings - Designed for Terminal Tool Compatibility
All Zellij control keybindings use **Ctrl+Alt** modifier instead of raw Ctrl to avoid conflicts with TUI applications like coding agents, text editors, and interactive CLI tools.

#### Tab Management (Ctrl+Alt)
- `Ctrl+Alt+t` - Enter tab mode
- `Ctrl+Alt+c` - Create new tab
- `Ctrl+Alt+x` - Close current tab
- `Ctrl+Alt+[` / `Ctrl+Alt+]` - Previous/next tab
- `Ctrl+Alt+1-9` - Go to specific tab

#### Pane Management (Ctrl+Alt)
- `Ctrl+Alt+p` - Enter pane mode
- `Ctrl+Alt+s` - Split down (new pane below)
- `Ctrl+Alt+v` - Split right (new pane to the right)
- `Ctrl+Alt+h/j/k/l` - Move focus left/down/up/right (vim-style)

#### Pane Focus & Navigation (Ctrl+Alt)
- `Ctrl+Alt+f` / `Ctrl+Alt+z` - Toggle focused pane fullscreen (maximizes current pane)
- `Ctrl+Alt+q` - Quit Zellij

## Installation

### With home-manager
Add to your `flake.nix`:

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    zellij-vivid-rounded.url = "github:deepwatrcreatur/nix-zellij-vivid-rounded";
  };

  outputs = { home-manager, zellij-vivid-rounded, ... }@inputs:
    {
      homeConfigurations.yourusername = home-manager.lib.homeManagerConfiguration {
        modules = [
          zellij-vivid-rounded.homeManagerModules.default
          # ... other modules
        ];
      };
    };
}
```

Then enable in your home-manager configuration:

```nix
programs.zellij-vivid-rounded = {
  enable = true;
  showStartupTips = false;
};
```

## Integrating with Custom Layouts (e.g., Yazelix)

You can reuse the theme in your own custom layouts by accessing the `lib` output from the flake input:

```nix
# In your home-manager module (e.g., yazelix.nix)
{ inputs, pkgs, ... }:
let
  # You might need to fetch the plugin WASM manually if it's not in your pkgs
  zjstatus-wasm = pkgs.fetchurl { ... };
in
{
  xdg.configFile."zellij/layouts/mylayout.kdl".text = ''
    layout {
        pane size=1 borderless=true {
            plugin location="file:${zjstatus-wasm}" {
                ${inputs.zellij-vivid-rounded.lib.topBar}
            }
        }
        // ... your panes ...
        pane size=2 borderless=true {
            plugin location="file:${zjstatus-wasm}" {
                ${inputs.zellij-vivid-rounded.lib.bottomBar}
            }
        }
    }
  '';
}
```

## Why Ctrl+Alt for Keybindings?

Standard Zellij uses raw Ctrl keybindings (Ctrl+p, Ctrl+t, etc.) which conflict with interactive terminal tools like:
- Claude Code and other coding agents (Ctrl+p for command palettes)
- Editors (Ctrl+s for save, Ctrl+t for new tab)
- TUI applications (vim, emacs, htop, etc.)

By using **Ctrl+Alt** instead, we free up raw Ctrl entirely for these applications while maintaining intuitive zellij control.

## License

MIT
