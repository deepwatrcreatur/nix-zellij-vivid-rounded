# Zellij Work Items

Start here if you are assigning another agent:

- [`START-HERE.md`](./START-HERE.md)

This folder is the agent-facing queue for `nix-zellij-vivid-rounded`.

## How To Use

- Treat each file in this folder as one PR-sized work stream.
- Prefer one agent per file/branch.
- Mark the file as `in-progress` in its header once an agent starts it.
- When work is fully merged, either delete the file or keep it briefly as
  `done` if it records useful outcome notes.
- `done` items must not remain in the active ranking; archive or delete them
  once their notes are no longer useful.

## Status Model

- `blocked`: do not start yet
- `ready`: can be started now
- `in-progress`: owned by an active branch / agent
- `done`: merged; may remain briefly for outcome notes, but should be archived
  or deleted and removed from the active ranking

## Ranking

Highest value first:

1. `01-deduplicate-home-manager-modules.md`
2. `02-module-customization-options.md`
3. `03-flake-checks-and-ci.md`
4. `04-status-bar-portability.md`
5. `05-lib-cleanups.md`
6. `06-clipboard-and-remote-docs.md`
7. `07-metadata-polish.md`
8. `08-flake-complexity-cleanup.md`

## Source

The seed roadmap for this queue comes from [`IMPROVEMENTS.md`](../../IMPROVEMENTS.md).
