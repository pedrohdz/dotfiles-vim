# Migration Plan - Transitioning NeoVim Plugin Configurations

This document outlines our plan for migrating from our old method of managing
plugins using the `after/plugin/` directory to using Lazy.nvim with our new
configurations in `home/.config/nvim/lua/pedrohdz/nvim/plugins`. We will migrate
the plugin configurations in increasing order of complexity. This incremental
approach minimizes risks and makes debugging easier.

## Overview

We begin by migrating the simplest configurations—mostly single-option settings
or basic helper functions. Once those are stable, we move on to more complex
integrations such as file explorers, LSP setups, and finally to our custom HUD
with internal state logic. At each step, we will verify plugin functionality
with Neovim's `:checkhealth` and other plugin-specific commands.

### Branch & Rollback Strategy

- Create a dedicated feature branch for every step (e.g. `migrate/netrw`,
  `migrate/gundo`, …).
- Keep the original `after/plugin/*` file _until_ the migrated Lazy module is
  committed **and** `make clean test` passes.
- If a step fails, revert the branch or cherry-pick the legacy file back, then
  reopen an issue.
- Merge to `main` only after the smoke-test and manual verification succeed.

## Migration Steps (Simplest to Most Complex)

Each step is considered **done** when:
- `make clean test` passes (headless smoke-test).
- `:checkhealth` reports no issues.
- The migrated feature is manually verified.
- The legacy `after/plugin` file has been removed.

1. **netrw.lua** *(DONE)*
   **Goal:** Disable netrw in favor of `nvim-tree`.
   **Migration Details:**
   - Convert the current Vimscript setting in `netrw.lua` to a Lua module.
   - Ensure `nvim-tree` loads in the same commit so disabling netrw does not
     break file-browsing workflows.

2. **gundo.lua**
   **Goal:** Transition Gundo configuration.
   **Migration Details:**
   - Migrate the simple global option settings.
   - Optionally, convert them to a Lua-based configuration if possible,
     maintaining any legacy behavior.

3. **fill-path.lua**
   **Goal:** Migrate the helper function and key mapping.
   **Migration Details:**
   - Port the helper function (getting and simplifying the current working
     directory) and the key mapping using Lua’s `vim.keymap.set` to the Lazy
     configuration.

4. **gist.vim**  **Goal:** Integrate the gist settings.  **Migration Details:**
   - Migrate global gist options and the sourcing of credentials.
   - Ensure that these settings are loaded at the appropriate stage in the
     Lazy.nvim setup.

5. **comment.lua**
   **Goal:** Transition the Comment plugin initialization.
   **Migration Details:**
   - Replace the `require('Comment').setup()` call in the after-plugin file
     with a similar call in the Lazy plugin configuration block.

6. **window-picker.lua**
   **Goal:** Migrate window-picker configuration.
   **Migration Details:**
   - Port the configuration (with its hint and filter rules) into a Lua module
     managed by Lazy.

7. **indent-blankline.lua**
   **Goal:** Migrate the indent guide configuration.
   **Migration Details:**
   - Switch to the successor plugin `ibl.nvim` (indent-blankline rewrite) and
     port the settings accordingly.
   - Validate that the visual indent lines are still working as intended.

8. **highlight-line.lua**
   **Goal:** Migrate current line and color column highlighting.
   **Migration Details:**
   - Convert the Vimscript autocommands for enabling/disabling cursorline and
     colorcolumn into Lua (if needed) or include the existing Vimscript as part
     of the Lazy load mechanism.

9. **diff.lua**
   **Goal:** Preserve diff mode behavior by adjusting window cursor placement.
   **Migration Details:**
   - Port the auto commands (that move the cursor when a buffer is in diff
     mode) into Lua under a Lazy-controlled autocommand.

10. **instant-rst.lua**
    **Goal:** Migrate InstantRst settings.
    **Migration Details:**
    - Move the global variable settings from Vimscript into Lua.
    - Ensure these settings are applied before InstantRst starts.

11. **todo-comments.lua**
    **Goal:** Transition the todo-comments setup.
    **Migration Details:**
    - Port the plugin’s configuration (highlight and search patterns) into the
      Lazy.nvim configuration block.

12. **nvim-tree.lua** *(DONE)*
    **Goal:** Migrate the file explorer’s floating window configuration and key
    mappings.
    **Migration Details:**
    - Move the floating window layout logic, autocommands (for resizing), and
      custom mappings into the Lazy configuration.
    - Confirm that file explorer behavior is consistent with previous usage.

13. **oil.lua**
    **Goal:** Migrate the more complex file explorer enhancements (Oil plugin).
    **Migration Details:**
    - Move over helper functions, window-picker integration, and multiple key
      mappings.
    - Ensure dynamic features (such as picking a target window and splitting
      behavior) continue to work post-migration.

14. **yaml.lua**
    **Goal:** Migrate conditional LSP attachment for YAML files.
    **Migration Details:**
    - Port the logic that checks whether a file is part of a Helm chart before
      attaching the YAML LSP.
    - Validate that YAML files not part of Helm charts still correctly trigger
      the LSP.

15. **nvim-lspconfig.lua**
    **Goal:** Migrate the comprehensive LSP and completion configuration.
    **Migration Details:**
    - Transition the extensive LSP server configuration—including capabilities,
      key mappings (detailed with which-key), and diagnostic settings—to the
      Lazy-based Lua configuration.
    - Verify that autocompletion, diagnostic display, and LSP server
      functionalities are working properly.

16. **hud.vim**
    **Goal:** Migrate the complete HUD configuration, which includes state
    toggling and integration with git signs, blankline, and diagnostics.
    **Migration Details:**
    - Convert multiple public and internal functions to Lua.
    - Re-implement state toggling (FULL, SIMPLE, NONE) and error handling in
      Lua.
    - Ensure that dependent commands (such as toggling git signs and indent
      guides) are executed in the correct order.

## Next Steps

- **Testing and Verification:**
  After migrating each file, test the configuration using Neovim’s
  `:checkhealth`, run plugin version commands to verify success, and leverage
  the aider auto-test system (via the configured test command, e.g., `make
  clean test`) to automatically run and validate tests. This integrated testing
  approach helps quickly identify and address regressions.

- **Incremental Commits:**  Migrate one file at a time and commit your changes
  incrementally. This helps isolate issues and simplifies rollback if needed.

- **Collaboration with Aider-Chat:**
  This document serves as the game plan for our collaboration with aider-chat.
  We can refer to these steps as we troubleshoot or update details on
  individual plugin migrations.

- **Additional Considerations:**
  - Verify that unmigrated plugins such as autopairs, conform,
    markdown-preview, and render-markdown are either integrated into the Lazy
    setup or appropriately documented if left using the traditional approach.
  - Convert any remaining Vimscript (e.g., hud.vim, highlight-line.lua) fully
    to Lua or ensure they are correctly wrapped for Lazy's lifecycle.
  - Clearly separate global versus local configuration settings to aid
    troubleshooting and maintain context.
  - Confirm that all plugin dependencies and load order are correctly declared
    and verified.

## Cleanup & Final Verification

1. Remove any empty `after/plugin` directory or orphaned *.vim/lua files.
2. Run `make clean test` to execute the full smoke-test
   (`scripts/nvim-smoke-test.sh`).
3. Run `nvim --headless "+Lazy health" "+qall"` and ensure **no** warnings
   appear.
4. Tag the commit once the above succeed.

## Conclusion

By following the above plan—from the simplest plugin configurations up to the
most involved ones—we aim to progressively transition to a modern,
Lazy.nvim-managed setup for NeoVim. This methodical approach ensures that each
piece functions correctly before moving on, maintaining a stable and efficient
development environment throughout the migration.

