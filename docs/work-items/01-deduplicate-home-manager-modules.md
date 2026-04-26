Status: `done`

Suggested branch: `refactor/zellij-module-dedup`

## Progress

- extracted shared Home Manager logic into `modules/home-manager/common/base.nix`
- refactored `module.nix` and `modules/home-manager/common/zellij.nix` to use the base module
- verified clean evaluation via `module-eval` flake check

## Goal

Remove the large duplication between `module.nix` and
`modules/home-manager/common/zellij.nix`.

## Tasks

- identify the shared settings and generation logic
- extract them into one reusable helper or function
- keep only intentional per-module differences
