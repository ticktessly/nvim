# lazy.nvim -> `vim.pack` migration

Migrated on branch `vim-pack-migration`. Targets Neovim **0.12.5**.

`vim.pack` is Neovim's built-in plugin manager. It has no spec DSL: plugins are
declared with plain Lua in `lua/plugins/*.lua`, and `vim.pack.add()` is called
from `init.lua` in dependency order.

---

## What replaced what

| lazy.nvim | `vim.pack` |
|---|---|
| `{ import = "plugins" }` spec files | one `lua/plugins/<name>.lua` per plugin, `require`d from `init.lua` |
| `lazy = false` / `priority` | order of the `require` calls in `init.lua` |
| `dependencies = { ... }` | list the dependency in the same `vim.pack.add()` call, **before** its user |
| `opts = { ... }` | `require('<main>').setup({ ... })` right after `vim.pack.add()` |
| `config = function(_, opts)` | body of the loader's setup function |
| `init = function()` | run that code **before** `vim.pack.add()` |
| `version = "1.*"` | `version = vim.version.range("1.*")` |
| `branch = "main"` / `tag` / `commit` | `version = "<branch\|tag\|commit>"` |
| `version = false` | `version = "<commit>"` (the documented freeze; no "never auto-update" flag exists) |
| `build = ...` | `PackChanged` autocmd in `lua/plugins/build.lua`, defined **before** `vim.pack.add()` |
| `event = "X"` | `nvim_create_autocmd("X", { once = true, callback = load })` |
| `event = "VeryLazy"` | `UIEnter` autocmd + `vim.schedule(load)` |
| `cmd = "Foo"` | `CmdUndefined` autocmd with `pattern = "Foo"` |
| `keys = { ... }` | real wrapper mappings that `load()` first (see *Keys* below) |
| `performance.rtp.disabled_plugins` | guard variables in `lua/config/rtp.lua` |
| `lazy-lock.json` | `nvim-pack-lock.json` (same config dir, **commit it**) |
| `:Lazy` | `:lua vim.pack.update()` (bound to `<leader>l`) |
| `:Lazy clean` | `vim.pack.get()` + `vim.pack.del()` |

### Two `load` details worth knowing

* `load = function() end` (in `lua/pack_utils.lua` as `no_load`) means *install and
  track, but do not put on `'runtimepath'`*. This is the documented way, and the
  only way — `load = false` is just `:packadd!`, which **does** load.
* `load` defaults to `vim.v.vim_did_init == 1`, i.e. `false` during `init.lua`,
  which still loads the plugin (`:packadd!`). So a plain `vim.pack.add{}` is eager.

---

## Plugin-by-plugin translation

All 17 plugins installed at **exactly** the commits recorded in `lazy-lock.json`
(verified with `vim.pack.get()` after install).

| plugin | lazy trigger | `vim.pack` trigger |
|---|---|---|
| `mini.icons` | eager (via `init`) | **eager**; `package.preload` shim kept, moved before `vim.pack.add` |
| `mini.statusline` | `VeryLazy` | `UIEnter` + `vim.schedule` |
| `mini.pairs` | `InsertEnter` | `InsertEnter` |
| `mini.ai` | `VeryLazy` | `UIEnter` + `vim.schedule` |
| `mini.files` | `keys` | wrapper mappings `<leader>e` / `<leader>E` |
| `friendly-snippets` | (blink.cmp dep) | lazy, loaded by blink's loader before blink.cmp |
| `blink.cmp` | `InsertEnter`, `CmdlineEnter` | both events, **one shared loader** |
| `plenary.nvim` | (telescope dep) | lazy, loaded by telescope's loader |
| `telescope-fzf-native.nvim` | (telescope dep, `build=make`) | lazy; `make` hook in `plugins/build.lua` |
| `telescope.nvim` | `cmd Telescope`, 3 keys | `CmdUndefined Telescope` + 3 wrapper mappings |
| `nvim-treesitter` | `BufReadPost`,`BufNewFile`; `TSUpdate`,`TSInstall`; `build=:TSUpdate` | same events, same commands (one shared loader); `:TSUpdate` hook in `plugins/build.lua` |
| `conform.nvim` | `BufWritePre`; `ConformInfo`; `<leader>F` | same; wrapper mapping |
| `nvim-lint` | `BufReadPost`,`BufWritePost`,`BufNewFile` | same events; its custom `lint` augroup kept |
| `bufferline.nvim` | `BufAdd`,`BufDelete`; `<S-h>`,`<S-l>` | same events; 2 wrapper mappings |
| `flash.nvim` | `VeryLazy`; `s` in n/x/o | `UIEnter` + `vim.schedule`; wrapper mapping |
| `noice.nvim` | `VeryLazy`; 9 keys | `UIEnter` + `vim.schedule`; mappings defined directly |
| `smear-cursor.nvim` | `VeryLazy` | `UIEnter` + `vim.schedule` |

No spec used `cond`, `enabled`, `dev`, `priority`, or `opts_extend`, and no plugin
appeared in two specs, so **no `opts` merging was needed**.

### Pinned versions

`lazy.nvim`'s `version = false` means "never auto-update". `vim.pack` has no such
flag; the documented freeze is `version` set to the current revision. These four
are pinned to their `lazy-lock.json` commits:

| plugin | pinned commit |
|---|---|
| `bufferline.nvim` | `655133c3b4c3e5e05ec549b9f8cc2894ac6f51b3` |
| `mini.ai` | `c2c4278beb759aa24b9506f56a67186a6cc2209c` |
| `mini.files` | `7821bb920b8f0b114c756fb9bd39fd62d76961ac` |
| `mini.statusline` | `127997ebef7ef632161203b960c5ef9d158f4810` |

**To unpin one:** delete its `version = "..."` field, then run
`:lua vim.pack.update({ '<name>' })`. (Nothing has been unpinned yet.)

### Keys: why there is no key-replay

Every plugin here has either an event/command trigger or at most 3 mappings, so
each mapping is a **real wrapper** that loads the plugin and then performs the
action. There is no `lazy_keys` stub/`nvim_feedkeys(..., "m")` replay anywhere,
which means none of the replay limitations (lost counts, registers, or
operator-pending state) can apply.

This matters most for `flash.nvim`: `s` is a *motion* mapped in normal, visual
**and operator-pending** mode, so `d s <target>` would break under replay. The
wrapper form is also exactly what flash.nvim's own README recommends.

For `cmd`-triggered plugins, the `CmdUndefined` autocmd only fires when the
command is actually run, so the plugin loads at that point and the command then
resolves normally.

---

## Behaviour differences and limitations

1. **`:Lazy` is gone.** `<leader>l` now runs `:lua vim.pack.update()`. There is no
   plugin list, no profiler and no update checker. See the command equivalents below.
2. **`disabled_plugins` needed a different mechanism.** lazy.nvim implemented it
   by setting `vim.go.loadplugins = false` and taking over all plugin loading
   itself. `vim.pack` has no equivalent, so `lua/config/rtp.lua` sets each bundled
   runtime file's own guard variable before Nvim sources `plugin/`
   (`g:loaded_netrwPlugin`, `g:loaded_tutor_mode_plugin`, `g:loaded_tarPlugin`,
   `g:loaded_zipPlugin`, `g:loaded_gzip`, `g:loaded_remote_plugins`,
   `g:loaded_spellfile_plugin`, `g:loaded_man`). Verified: `:Explore`, `:Man`,
   `:Sign` and the gzip `BufReadPre` autocmd are all absent, same as before.
   (`dir` was in the old list but `dir.vim` no longer exists in Neovim.)
3. **noice's lazy-UI hack was dropped.** The old config had
   `if vim.o.filetype == "lazy" then vim.cmd("messages clear") end`, which existed
   only because Lazy printed messages while installing plugins.
4. **Command completion before load.** `Telescope`, `TSUpdate`, `TSInstall` and
   `ConformInfo` do not exist for command-line completion until the plugin loads.
   Running the command still works — that is what loads it.
5. **`vim.g.editorconfig` was left unset**, exactly as before. If you want to turn
   editorconfig support off, add `vim.g.editorconfig = false` to `init.lua`.
6. **`packpath` had to be extended.** This build ships `'packpath'` containing only
   the runtime dir, but `vim.pack` installs into `stdpath('data')/site/pack/core/opt`
   and that directory must be on `'packpath'` (`:h vim.pack`). `init.lua` appends it
   as its first statement. Without this, every `:packadd` would fail.
7. **`:packadd` is not idempotent** — it re-sources `plugin/` on every call. All
   loaders are therefore guarded by `make_loader`, and multiple triggers on the
   same plugin share one loader.
8. **First launch prompts** to confirm installs (`confirm = true`, the default). In
   headless/scripted runs there is no UI to prompt with, so `lua/pack_utils.lua`
   sets `confirm = false` when `#nvim_list_uis() == 0`.

---

## Startup time

`nvim --startuptime <log> +qa`, warm caches, `NVIM STARTED` timestamp:

| | before (lazy.nvim) | after (`vim.pack`) |
|---|---|---|
| samples | 5 | 10 |
| min | 82.1 ms | 71.8 ms |
| **median** | **82.7 ms** | **74.0 ms** |
| max | 89.8 ms | 110.9 ms |

**~8.7 ms (≈10%) faster.** The plugin manager itself went from **20.7 ms** of
self time across 22 `lazy.*` modules to **1.75 ms** across 5 `vim.pack` modules.
Part of that saving is given back by `loading rtp plugins` (2.6 ms), which now
runs because `loadplugins` is back on — previously lazy had turned it off and
sourced runtime plugins itself.

Only `mini.icons` (~4.3 ms) is still paid for at startup, exactly as before.
Everything else is loaded on demand.

---

## Commands now

| action | command |
|---|---|
| update all | `:lua vim.pack.update()` (confirmation buffer; `:write` applies, `:quit` discards) |
| browse installed | `:lua vim.pack.update(nil, { offline = true })` (`[[`/`]]` to move, `gO` for structure, `K` for details) |
| update one | `:lua vim.pack.update({ 'telescope.nvim' })` |
| list plugins | `:lua print(vim.inspect(vim.pack.get()))` |
| update without network | `:lua vim.pack.update(nil, { offline = true })` |
| force update | `:lua vim.pack.update(nil, { force = true })` |
| revert to lockfile | `:lua vim.pack.update({ 'name' }, { offline = true, target = 'lockfile' })` |
| health | `:checkhealth vim.pack` |

## Adding / pinning / removing a plugin

**Add** — add a file `lua/plugins/<name>.lua`, then `require` it from `init.lua`
after any plugin it depends on:

```lua
local gh = require("pack_utils").gh
vim.pack.add({ gh("owner/repo") }, require("pack_utils").no_load)
-- then define triggers with require("pack_utils").make_loader({ "<name>" }, setup)
```

**Pin** — put the commit hash in `version`, e.g. `{ src = gh("owner/repo"), version = "abc1234" }`.

**Remove** — three steps, in this order:
1. Delete the spec (the `lua/plugins/<name>.lua` file and its `require` line in `init.lua`).
2. Restart Neovim.
3. Delete it from disk:
   ```lua
   -- find the ones no longer in the config:
   vim.iter(vim.pack.get()):filter(function(p) return not p.active end):map(function(p) return p.spec.name end):totable()
   -- then remove the ones you want gone:
   vim.pack.del({ "old-plugin" })   -- add { force = true } if it is still active
   ```

## Files

```
init.lua                     packpath fix, leader, then requires in dependency order
lua/pack_utils.lua           gh(), no_load, eager, make_loader()
lua/config/rtp.lua           disabled_plugins -> guard variables
lua/config/keymaps.lua       jj, <leader>l
lua/config/opts.lua          options (unchanged)
lua/config/autocmd.lua       yank highlight, LspAttach maps (unchanged)
lua/plugins/build.lua        PackChanged build hooks (must precede vim.pack.add)
lua/plugins/*.lua            one per plugin
lsp/*.lua                    unchanged (native vim.lsp, never used lazy)
```