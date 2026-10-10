---@brief
---
--- Small helpers for `vim.pack`. Not a framework: just the three things every
--- plugin file needs -- a GitHub shorthand, the "install but don't load" option
--- table, and an idempotent loader.
---
--- See `:h vim.pack`.

local M = {}

--- Shorthand for a GitHub repository URL.
---@param repo string e.g. "folke/noice.nvim"
---@return string
function M.gh(repo)
  return "https://github.com/" .. repo
end

--- `#nvim_list_uis() == 0` means we are running headless (`--headless`, `-l`, CI).
--- `vim.pack.add()`'s `confirm` uses `vim.fn.confirm()`, which would block a
--- non-interactive run forever, so installs are only confirmed when there is a UI.
---@type boolean
local headless = #vim.api.nvim_list_uis() == 0

--- Options for a plugin that should be *installed and tracked* but not loaded
--- during startup. `load = <function>` is the documented way to say "don't load
--- me": the function is called instead of `:packadd` and is fully responsible
--- for loading (see `:h vim.pack.add()`, `opts.load`).
---
--- NOTE: `load = false` would *not* work -- that is just `:packadd!`.
M.no_load = {
  load = function() end,
  confirm = not headless,
}

--- Options for a plugin that is loaded eagerly. We only override `confirm`;
--- `load` keeps its default, which during `init.lua` is `:packadd!`.
M.eager = { confirm = not headless }

--- Build an idempotent loader for one or more plugins.
---
--- `names` are added to the runtimepath in order, so list dependencies first
--- (e.g. `{ "plenary.nvim", "telescope.nvim" }`). `:packadd` is *not*
--- idempotent -- it re-sources `plugin/` files on every call -- so the loader
--- must only ever run once. Every trigger for a plugin should share one loader.
---@param names string[] plugin names, dependencies first
---@param setup? fun() run once, after the plugins are on the runtimepath
---@return fun() loader
function M.make_loader(names, setup)
  local done = false
  return function()
    if done then
      return
    end
    done = true
    for _, name in ipairs(names) do
      vim.cmd.packadd(name)
    end
    if setup then
      setup()
    end
  end
end

return M