Status: `in-progress`
Suggested branch: `refactor/zellij-module-dedup`
Priority: `high`

# Deduplicate Home Manager Modules

## Goal

Remove the large duplication between `module.nix` and
`modules/home-manager/common/zellij.nix`.

## Tasks

- identify the shared settings and generation logic
- extract them into one reusable helper or function
- keep only intentional per-module differences
