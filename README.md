# nix-zellij-vivid-rounded

A highly customized [Zellij](https://zellij.dev/) configuration for NixOS/home-manager featuring vivid colors, rounded tab indicators, and thoughtfully remapped keybindings.

## Features

### Visual Design
- **Catppuccin Mocha theme**: Dark mode with carefully balanced color palette
  - Dark background (#2a2b3a) for all bars and elements
  - Subtle gray text (#737c8a) for primary content
  - Vivid colors only on rounded corner indicators (blue, green, yellow, orange, purple)
- **Rounded corner separators**: Visual section boundaries using left/right half-circles (◐ ◑)
- **Solid status bars**: Continuous dark background across entire width of top and bottom rows
- **Custom layout**:
  - Top: Session name + tabs + user@host + memory
  - Bottom: Current mode + keybinding hints + memory usage

### Clipboard & Text Selection
- **Automatic copy-to-clipboard**: Text selection automatically copies to system clipboard
- Works locally and over SSH (uses system clipboard backend)

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

#### Modal Commands (vim-style)
Once you enter a mode with Ctrl+Alt+t (tab) or Ctrl+Alt+p (pane):

**Tab Mode** (after Ctrl+Alt+t):
- `h` / `l` - Previous/next tab
- `1-9` - Go to specific tab
- `c` - Create new tab
- `x` - Close current tab
- `r` - Rename tab
- `s` - Enter session mode
- `Esc` - Return to normal mode

**Pane Mode** (after Ctrl+Alt+p):
- `h/j/k/l` - Move focus left/down/up/right
- `p` - New pane to the left
- `n` - New pane below
- `x` - Close focused pane
- `f` / `z` - Toggle pane fullscreen
- `Esc` - Return to normal mode

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
programs.zellij-vivid-rounded.enable = true;
```

## Why Ctrl+Alt for Keybindings?

Standard Zellij uses raw Ctrl keybindings (Ctrl+p, Ctrl+t, etc.) which conflict with interactive terminal tools like:
- Claude Code and other coding agents (Ctrl+p for command palettes)
- Editors (Ctrl+s for save, Ctrl+t for new tab)
- TUI applications (vim, emacs, htop, etc.)

By using **Ctrl+Alt** instead, we free up raw Ctrl entirely for these applications while maintaining intuitive zellij control.

## About "Pane Fullscreen"

The `[f]ull` hint in the bottom status bar refers to **pane focus fullscreen**, not terminal fullscreen:
- `Ctrl+Alt+f` or `Ctrl+Alt+z` maximizes the currently focused pane to fill the window
- This hides other panes temporarily for a focused editing session
- Press again to restore the pane layout
- When in pane mode (`Ctrl+Alt+p`), you can also use `f` or `z` to toggle

This is different from traditional terminal fullscreen (F11) which would maximize the Zellij window itself.

## Customization

### Configuration Options

The module provides a `programs.zellij-vivid-rounded` option to control the setup:

```nix
programs.zellij-vivid-rounded = {
  enable = true;  # Enable the module (default: false)
};
```

### Further Customization

You can extend or override this configuration:

- **Theme colors**: Modify `config.programs.zellij.settings.themes.catppuccin-mocha`
- **Keybindings**: Add or override bindings in `config.programs.zellij.settings.keybinds`
- **Layout**: Edit the KDL layout file in `xdg.configFile."zellij/layouts/extended.kdl"`
- **UI settings**: Customize `config.programs.zellij.settings.ui` for pane frame appearance

Example: Override tab colors in your home configuration:

```nix
{
  imports = [ zellij-vivid-rounded.homeManagerModules.default ];

  programs.zellij-vivid-rounded.enable = true;

  # Override specific settings
  programs.zellij.settings.themes.catppuccin-mocha.green = "#90ee90";
}
```

## Screenshot

![Zellij with vivid rounded tabs](./screenshot.png)

The screenshot shows:
- Light blue (`#89B4FA`) top and bottom bars
- Light green (`#a6e3a1`) active tab highlight
- Vim-style keybinding hints in the status bar with colored boxes by category
- Multiple tabs with pill-shaped backgrounds
- System info in top-right: OS symbol + user@host + memory usage

### Current State (Latest Aesthetic)

The current design implements a tmux-inspired aesthetic with:

✅ **Visual Design:**
- **Solid dark bars** - Continuous dark background (#2a2b3a) across entire top and bottom rows
- **Subtle text highlighting** - All text in subtle gray (#737c8a) for understated appearance
- **Rounded corner separators** - Left/right facing rounded half-circles (◐ ◑) between sections
- **Vivid accent colors** - Colors only used on rounded corner indicators and section dividers
- **Proper tab bars** - Tabs displayed with dark background and proper styling
- **Clean sections** - Clear visual separation between session/tabs/user@host (top) and mode/hints/memory (bottom)

The design philosophy prioritizes clarity and readability by using:
- Dark neutral backgrounds as the foundation
- Subtle gray text for primary content
- Vivid accent colors only at strategic section boundaries
- Consistent spacing and alignment throughout

## License

MIT
