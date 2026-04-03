# Repository Improvement Suggestions

## High impact

1. **Deduplicate the two Home Manager modules.**
   - `module.nix` and `modules/home-manager/common/zellij.nix` are largely the
     same and are likely to drift.
   - Extract the shared settings into one function or helper and keep only
     small per-module overrides.

2. **Add wrapper/runtime behavior checks.**
   - Add lightweight flake checks or shell tests for the generated Zellij
     configuration paths and any key behavior that can regress silently.

3. **Expose more customization through module options.**
   - Theme name, layout name, keybinding strategy, and status-bar commands are
     largely hardcoded today.
   - Add options so the module remains reusable while preserving current
     defaults.

## Medium impact

4. **Fix duplicated config lines and minor maintenance drift.**
   - `border_enabled "false"` appears twice in `lib.nix`.
   - Clean up small accidental duplication before it spreads.

5. **Improve status-bar command portability.**
   - Commands like `free -h | grep Mem | awk ...` are Linux-specific and may
     fail in minimal systems, containers, or Darwin environments.
   - Make them configurable and document expected host tools.

6. **Add flake checks and CI hooks.**
   - Add formatting and evaluation checks, and optionally a reference module
     evaluation path for one system.

## Nice to have

7. **Document clipboard and remote caveats more clearly.**
   - Clipboard behavior over SSH depends on OSC52/terminal/backend support and
     should include a short troubleshooting note.

8. **Add metadata polish.**
   - Add maintainers and any missing `meta` details to exposed packages/modules.

9. **Keep flake iteration strategy consistent.**
   - Remove unused helper bindings and keep the flake structure simpler where
     possible.
