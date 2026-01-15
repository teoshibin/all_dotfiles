return {
    'stevearc/oil.nvim',
    keys = {
        { "-", "<cmd>lua require('oil').toggle_float()<CR>", desc = "Oil File Manager" }
    },
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
        default_file_explorer = false,
        delete_to_trash = true,
        watch_for_changes = false,
        view_options = {
            show_hidden = true,
        },
        float = {
            padding = 5,
            max_width = 0.4,
            max_height = 0.8,
            win_options = {
                winblend = 5,
            },
            border = "single",
        },
        keymaps = {
            ["-"] = { "actions.close", mode = "n" },
        },
    },
    config = function(_, opts)
        local oil = require("oil")
        oil.setup(opts)

        -- hard-disable netrw's directory autocmds (the thing that handles `nvim .` and :edit <dir>)
        pcall(vim.api.nvim_clear_autocmds, { group = "FileExplorer" })
        vim.api.nvim_create_autocmd("VimEnter", {
            once = true,
            callback = function()
                pcall(vim.api.nvim_clear_autocmds, { group = "FileExplorer" })
            end,
        })

        vim.api.nvim_create_autocmd("BufEnter", {
            group = vim.api.nvim_create_augroup("oil_hijack_dirs_float", { clear = true }),
            pattern = "*",
            callback = function()
                vim.schedule(function()
                    local name = vim.api.nvim_buf_get_name(0)
                    if name == "" or vim.fn.isdirectory(name) == 0 then return end

                    -- keep a normal window underneath (do NOT wipe/close it)
                    vim.cmd("enew")

                    -- now open Oil as a float rooted at the directory
                    oil.open_float(name)
                end)
            end,
        })
    end,
    dependencies = {
        { "nvim-mini/mini.icons", opts = {} }
    },
    lazy = false
}
