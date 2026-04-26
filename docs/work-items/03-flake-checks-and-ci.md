Status: `done`

Suggested branch: `feat/zellij-flake-checks`

## Progress

- added `formatting` check using `nixfmt-rfc-style`
- added `lib-eval` check to verify `topBar` and `bottomBar` strings
- added `module-eval` check with Home Manager mockup to verify declarative settings

## Goal

Add lightweight checks that validate formatting, evaluation, and basic module
import behavior.

## Tasks

- add `nix flake check` coverage
- add formatter checks if appropriate
- add one cheap module-evaluation path
