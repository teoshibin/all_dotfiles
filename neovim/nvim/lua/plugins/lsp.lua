return {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
    opts = {
        automatic_enable = true,
        ensure_installed = {
            "lua_ls",
        },
    },
    config = function(_, opts)
        require("mason-lspconfig").setup(opts)
        -- using custom installed kotlin lsp, not from mason
    end,
}
