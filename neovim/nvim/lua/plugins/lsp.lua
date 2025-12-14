return {
    "mason-org/mason-lspconfig.nvim",
    opts = {
        automatic_enable = true,
        ensure_installed = {
            "lua_ls",
            -- https://github.com/Kotlin/kotlin-lsp/releases
            -- "kotlin_lsp", This is currently broken on windows
        }
    },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
}
