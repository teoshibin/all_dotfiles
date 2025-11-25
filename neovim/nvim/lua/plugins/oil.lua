return {
    {
        enabled = true,
        -- file manager
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            delete_to_trash = true,
            view_options = {
                show_hidden = true,
            },
            float = {
                padding = 5,
                win_options = {
                    winblend = 5,
                },
            },
            keymaps = {
                ["<leader>-"] = "actions.close",
            },
        },
        cmd = "Oil",
        keys = {
            { "<leader>-", "<CMD>Oil<CR>", mode = "n", desc = "Toggle oil file manager" },
        },
    }
}
