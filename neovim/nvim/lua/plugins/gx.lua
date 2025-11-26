return {
    -- gx for opening url as netrw is disabled
    "chrishrb/gx.nvim",
    keys = {
        { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } },
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        handler_options = {
            search_engine = "google",
        }
    }
}
