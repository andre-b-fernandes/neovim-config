# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration repository using **lazy.nvim** as the plugin manager. The entire configuration is contained in a single `init.lua` file (~497 lines).

## Configuration Structure

**Single-file architecture**: All plugin specifications, LSP configurations, keymaps, and settings are in `init.lua`. There are no separate lua modules or plugin subdirectories.

Key sections in init.lua (in order):
1. Leader key setup (`,`)
2. lazy.nvim bootstrap
3. Plugin specifications (lines 20-301)
4. LSP capability setup (line 303)
5. Custom attach function with LSP keymaps (lines 311-335)
6. Python virtual environment detection (lines 338-367)
7. LSP auto-start autocmds for Python, Elixir, C/C++, Java, Lua (lines 370-463)
8. General Neovim settings and diagnostic config (lines 465-489)
9. Additional keymaps (lines 492-497)

## Plugin Management

After editing init.lua:
- `:Lazy` - Open lazy.nvim UI
- `:Lazy sync` - Install/update/clean plugins
- `:Lazy clean` - Remove unused plugins
- `:Lazy update` - Update all plugins

Changes require Neovim restart or `:source %` to take effect.

## LSP Configuration

**LSP servers are auto-started** via `FileType` autocmds (not manual `:LspStart`). Each server has hardcoded paths:

- **Python**: Pyright at `/Users/fernandoandrefernandes/.nvm/versions/node/v20.15.1/bin/pyright-langserver`
  - Auto-detects virtual environments (`.venv`, `venv`, `env`, VIRTUAL_ENV, CONDA_PREFIX)
- **Elixir**: ElixirLS at `/Users/fernandoandrefernandes/.vscode/extensions/jakebecker.elixir-ls-0.24.2/elixir-ls-release/language_server.sh`
- **C/C++**: clangd (expects in PATH)
- **Java**: JDTLS at `/Users/fernandoandrefernandes/jdt-language-server-1.46.0-202502271940/bin/jdtls`
- **Lua**: lua-language-server (expects in PATH)

When modifying LSP configs, verify paths exist and are executable. The custom_attach function (line 311) sets all LSP keymaps.

## Key Bindings

Leader key: `,`

**File navigation**:
- `,b` - Toggle NERDTree
- `,p` - Telescope find files (with ripgrep, includes hidden)
- `,f` - Telescope live grep

**LSP** (only active when LSP attaches):
- `K` - Show hover documentation/signature for symbol under cursor
- `,d` - Go to definition
- `,ar` - Rename symbol
- `,an` - Code actions
- `,=` - Format buffer
- `,ee` - Open diagnostic float
- `[d` / `]d` - Previous/next diagnostic

**Claude Code plugin**:
- `,ac` - Toggle Claude Code
- `,af` - Focus Claude Code
- `,ab` - Add current buffer to Claude
- `,aa` - Accept diff
- `,ad` - Deny diff

**REPL (iron.nvim)**:
- `<space>rs` - Start REPL
- `<space>sc` - Send code to REPL
- `<space>sl` - Send line

**Window management**:
- `,k` / `,l` - Resize vertical
- `,h` / `,j` - Resize horizontal
- `,i` - Open terminal

## Important Notes

- **Denops** requires Deno at `/Users/fernandoandrefernandes/.deno/bin/deno`
- **COC** has multi-cursor support via `<C-d>` (requires coc.nvim to be fully loaded)
- **Treesitter** auto-installs parsers but disables highlighting for C and Rust
- **git-blame** is disabled by default (`gitblame_enabled = 0`), toggle with `:GitBlameToggle`
- **Markdown preview** requires yarn: `cd app && npx --yes yarn install` (runs on plugin build)

## Testing Configuration Changes

1. Edit init.lua
2. Open Neovim in this directory: `nvim init.lua`
3. Source the file: `:source %` or restart Neovim
4. Check for errors: `:messages`
5. Verify plugins loaded: `:Lazy`
6. Test LSP by opening a Python/Lua file and checking `:LspInfo`

## File Management

- `lazy-lock.json` - Plugin version lockfile (commit this)
- `compile_flags.txt` - C/C++ compiler flags for clangd