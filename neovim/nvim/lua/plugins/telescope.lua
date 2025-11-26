return {
    "nvim-telescope/telescope.nvim",
    tag = "v0.1.9",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()

        -- Additional preview sroll
        -- https://github.com/nvim-telescope/telescope.nvim/issues/2602
        local full_page_scroll = function(prompt_bufnr, direction)
            local previewer = action_state.get_current_picker(prompt_bufnr).previewer
            local status = state.get_status(prompt_bufnr)
            -- Check if we actually have a previewer and a preview window
            if type(previewer) ~= "table" or previewer.scroll_fn == nil or status.preview_win == nil then
                return
            end
            local speed = vim.api.nvim_win_get_height(status.preview_win)
            previewer:scroll_fn(speed * direction)
        end

        return {
            defaults = {
                prompt_prefix = "   ",
                -- selection_caret = " ",
                -- entry_prefix = " ",
                sorting_strategy = "ascending",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.55,
                    },
                    width = 0.87,
                    height = 0.80,
                },
                mappings = {
                    n = { ["q"] = require("telescope.actions").close },
                    i = {
                        ["<C-b>"] = function(bufnr)
                            full_page_scroll(bufnr, 1)
                        end,
                        ["<C-f>"] = function(bufnr)
                            full_page_scroll(bufnr, -1)
                        end,
                    },
                },
            },
        }
end,
    keys = {
        { "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "Telescope find files" },
        { "<leader>sw", "<cmd>Telescope live_grep<cr>",  desc = "Telescope live grep" },
        { "<leader>sb", "<cmd>Telescope buffers<cr>",    desc = "Telescope buffers" },
        { "<leader>sh", "<cmd>Telescope help_tags<cr>",  desc = "Telescope help tags" },
        { "<leader>sk", "<cmd>Telescope keymaps<cr>",    desc = "Telescope keymaps" },
    },
}
