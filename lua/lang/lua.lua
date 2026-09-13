return {
    -- Treesitter parsers for Lua
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { "lua", "luadoc", "luap" })
        end,
    },

    -- Neovim API completion & type definitions for Lua
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },

    -- Add lazydev source to blink.cmp
    {
        "saghen/blink.cmp",
        opts = function(_, opts)
            opts.sources = opts.sources or {}
            opts.sources.default = opts.sources.default or {}
            if not vim.tbl_contains(opts.sources.default, "lazydev") then
                table.insert(opts.sources.default, 1, "lazydev")
            end
            opts.sources.providers = opts.sources.providers or {}
            opts.sources.providers.lazydev = {
                name = "LazyDev",
                module = "lazydev.integrations.blink",
                score_offset = 100,
            }
        end,
    },

    -- LSP setup for Lua (emmylua_ls)
    {
        "neovim/nvim-lspconfig",
        opts = function()
            vim.lsp.config("emmylua_ls", {
                on_init = function(client)
                    if client.workspace_folders then
                        local path = client.workspace_folders[1].name
                        if
                            path ~= vim.fn.stdpath("config")
                            and (vim.uv.fs_stat(path .. "/.emmyrc.json") or vim.uv.fs_stat(path .. "/.luarc.json"))
                        then
                            client.config.settings = {}
                        end
                    end
                end,
                settings = {
                    emmylua = {
                        runtime = { version = "LuaJIT" },
                        diagnostics = { globals = { "vim" } },
                        workspace = {
                            library = {
                                vim.env.VIMRUNTIME,
                                vim.api.nvim_get_runtime_file("lua/lspconfig", false)[1],
                            },
                        },
                    },
                },
            })
            vim.lsp.enable("emmylua_ls")
        end,
    },

    -- Formatter for Lua
    {
        "stevearc/conform.nvim",
        opts = function(_, opts)
            opts.formatters_by_ft = opts.formatters_by_ft or {}
            opts.formatters_by_ft.lua = { "stylua" }
        end,
    },

    -- Linter for Lua
    {
        "mfussenegger/nvim-lint",
        opts = function(_, opts)
            opts.linters_by_ft = opts.linters_by_ft or {}
            opts.linters_by_ft.lua = { "luacheck" }
        end,
    },
}
