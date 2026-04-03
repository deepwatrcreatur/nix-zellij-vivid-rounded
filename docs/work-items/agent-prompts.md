# Zellij Agent Prompts

Before using any prompt, read:

- [`START-HERE.md`](./START-HERE.md)

## Prompt 1: Deduplicate Home Manager Modules

Work on [`01-deduplicate-home-manager-modules.md`](./01-deduplicate-home-manager-modules.md).

Create a branch named `refactor/zellij-module-dedup`.

Task:
- extract shared settings between `module.nix` and
  `modules/home-manager/common/zellij.nix`
- keep only small per-module overrides where behavior intentionally differs

## Prompt 2: Module Customization Options

Work on [`02-module-customization-options.md`](./02-module-customization-options.md).

Create a branch named `feat/zellij-module-options`.

Task:
- expose the most important hardcoded settings as module options while
  preserving current defaults

## Prompt 3: Flake Checks And CI

Work on [`03-flake-checks-and-ci.md`](./03-flake-checks-and-ci.md).

Create a branch named `feat/zellij-flake-checks`.

Task:
- add lightweight flake checks and any minimal CI hooks that validate the repo
  without adding heavy maintenance burden

## Prompt 4: Status Bar Portability

Work on [`04-status-bar-portability.md`](./04-status-bar-portability.md).

Create a branch named `fix/zellij-status-portability`.

Task:
- make status-bar shell commands more portable and overrideable

## Prompt 5: Lib Cleanups

Work on [`05-lib-cleanups.md`](./05-lib-cleanups.md).

Create a branch named `fix/zellij-lib-cleanups`.

Task:
- clean up duplicated config lines and other low-risk maintenance issues in
  `lib.nix`

## Prompt 6: Clipboard And Remote Docs

Work on [`06-clipboard-and-remote-docs.md`](./06-clipboard-and-remote-docs.md).

Create a branch named `docs/zellij-clipboard-caveats`.

Task:
- tighten README caveats around clipboard behavior over SSH and remote
  environments

## Prompt 7: Metadata Polish

Work on [`07-metadata-polish.md`](./07-metadata-polish.md).

Create a branch named `chore/zellij-meta-polish`.

Task:
- add maintainers and other useful metadata polish where missing

## Prompt 8: Flake Complexity Cleanup

Work on [`08-flake-complexity-cleanup.md`](./08-flake-complexity-cleanup.md).

Create a branch named `refactor/zellij-flake-cleanup`.

Task:
- simplify minor flake complexity and remove unused helpers without changing
  behavior
