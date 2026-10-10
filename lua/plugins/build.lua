---@brief
---
--- Build hooks, replacing lazy.nvim's `build = ...` field.
---
--- `vim.pack` has no `build` field. The documented replacement is a `PackChanged`
--- autocmd (`:h vim.pack-events`), and the docs are explicit that it must be
--- defined *before* `vim.pack.add()` so it also fires on the initial install.
---
--- This module is required from `init.lua` before any plugin file.
---
--- Event data (`:h vim.event.packchanged.data`):
---   active - whether the plugin was added via `vim.pack.add()` this session
---   kind   - "install" | "update" | "delete"
---   spec   - the resolved spec (`.name` is the `:packadd` name)
---   path   - full path to the plugin directory

vim.api.nvim_create_autocmd("PackChanged", {
  desc = "Run build steps for vim.pack plugins (was lazy `build`)",
  callback = function(ev)
    local data = ev.data
    if data.kind ~= "install" and data.kind ~= "update" then
      return
    end
    local name = data.spec.name

    if name == "nvim-treesitter" then
      -- :TSUpdate needs the plugin's own commands. On `install` the plugin is
      -- on disk but *not* yet on 'runtimepath', and `active` is true even for
      -- `load = function() end` plugins, so check the runtimepath explicitly.
      -- (:packadd re-sources plugin/ on every call, so only do this if needed.)
      if not vim.tbl_contains(vim.api.nvim_list_runtime_paths(), data.path) then
        vim.cmd.packadd(name)
      end
      vim.cmd("TSUpdate")
    elseif name == "telescope-fzf-native.nvim" then
      -- Pure C library, no plugin code needed to build it.
      vim.system({ "make" }, { cwd = data.path }):wait()
    end
  end,
})