Status: `done`

Suggested branch: `fix/zellij-status-portability`

## Progress

- parameterized `userHostCommand` and `memoryCommand` in `lib.nix` and `module.nix`
- added `userHostInterval` and `memoryInterval` options for better configurability
- documented host-tool assumptions (e.g. `free -h` for Linux) in option descriptions

## Goal

Make status-bar shell commands more portable and configurable.

## Tasks

- identify Linux-specific or brittle commands
- add options or overrides so users can replace them cleanly
- document host-tool assumptions
