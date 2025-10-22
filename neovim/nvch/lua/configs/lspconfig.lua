-- NOTE: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

-- Copied from nvchad to customize keymaps
local nvlsp = require("configs.nvlspconfig")
local on_attach = nvlsp.on_attach
local on_init = nvlsp.on_init
local capabilities = nvlsp.capabilities

-- local lspconfig = require("lspconfig")

-- local function defaults(mods)
--     return vim.tbl_deep_extend("force", {
--         on_init = on_init,
--         on_attach = on_attach,
--         capabilities = capabilities,
--     }, mods)
-- end

-- Auto Configuration --

vim.lsp.config("*", {
  on_init = on_init,
  capabilities = capabilities,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event) on_attach(nil, event.buf) end,
})

-- for _, lsp in ipairs(servers) do
--     lspconfig[lsp].setup(defaults({}))
-- end

-- English --
-- lspconfig.ltex.setup(defaults({
--     cmd = { vim.fn.stdpath("data") .. "/mason/bin/ltex-ls" },
--     settings = {
--         ltex = {
--             language = "en-GB",
--         },
--     },
-- }))
vim.lsp.config("ltex", {
  cmd = { vim.fn.stdpath("data") .. "/mason/bin/ltex-ls" },
  settings = { ltex = { language = "en-GB" } },
})

-- Markdown --
vim.lsp.config("marksman", {})

-- Java --
vim.lsp.config("jdtls", {})

-- Python --
vim.lsp.config("basedpyright", {})

-- GO --
vim.lsp.config("gopls", {})

-- Powershell --
-- lspconfig.powershell_es.setup(defaults({
--     bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services/",
-- }))
vim.lsp.config("powershell_es", {
  bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services/",
})

-- Old Kotlin --
-- https://github.com/fwcd/kotlin-language-server
-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/kotlin_language_server.lua
-- Doesn't update immediately after escape, sometimes require to escape multiple times for it to detect the changes
-- Install java, kotlin, gradle (probably not required) and the server itself through mason
-- local function kt_root_dir(filename)
--     local norm_name = vim.fs.normalize(filename)
--     local util = require("lspconfig.util")
--     return util.root_pattern(table.unpack({
--         "settings.gradle", -- Gradle (multi-project)
--         "settings.gradle.kts", -- Gradle (multi-project)
--         "build.xml", -- Ant
--         "pom.xml", -- Maven
--         "build.gradle", -- Gradle
--         "build.gradle.kts", -- Gradle
--         ".git",
--     }))(norm_name)
-- end
-- lspconfig.kotlin_language_server.setup(defaults({
--     root_dir = kt_root_dir,
--     single_file_support = true,
--     cmd = { "kotlin-language-server" },
--     settings = {},
--     init_options = {
--         storagePath = kt_root_dir(vim.fn.expand("%:p:h")),
--         -- provideFormatter = true,
--         embeddedLanguages = { css = true, javascript = true },
--         configurationSection = { "html", "css", "javascript" },
--     },
-- }))

-- Official Kotiln --
-- lspconfig.kotlin_lsp.setup(defaults({
--     cmd = { "kotlin-lsp", "--stdio" },
--     filetypes = { "kotlin" },
--     root_markers = { "settings.gradle", "settings.gradle.kts", "pom.xml", "build.gradle", "build.gradle.kts", "workspace.json" },
-- }))

-- GDScript --
-- local port = os.getenv("GDScript_Port") or "6005"
-- local nc_ex = require("custom.os").isWindows() and "ncat" or "nc"
-- lspconfig.gdscript.setup(defaults({
--     -- Note: install windows netcat: https://nmap.org/download.html
--     cmd = { nc_ex, "localhost", port },
-- }))
local port = os.getenv("GDScript_Port") or "6005"
local nc_ex = require("custom.os").isWindows() and "ncat" or "nc"
vim.lsp.config("gdscript", { cmd = { nc_ex, "localhost", port } })

-- GDShadeer --
vim.lsp.config("gdshader_lsp", {})

-- Enable language servers
local servers = {
    "ltex",     -- grammar check
    "marksman", -- markdown
    "jdtls",    -- java
    "basedpyright", -- python
    "gopls",
    "powershell_es",
    "gdshader_lsp",
}
vim.lsp.enable(servers)

