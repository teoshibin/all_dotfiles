return {
    'stevearc/oil.nvim',
    keys = {
        { "-", "<cmd>Oil<cr>", desc = "Oil File Manager" }
    },
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
        default_file_explorer = true,
        delete_to_trash = true,
        watch_for_changes = false,
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
            ["-"] = { "actions.close", mode = "n" },
        },
    },
    dependencies = { 
        { "nvim-mini/mini.icons", opts = {} } 
    },
    lazy = false
}
