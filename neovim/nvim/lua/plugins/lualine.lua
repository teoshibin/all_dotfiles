return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        options = {
            component_separators = { left = " ", right = " "},
            section_separators = { left = " ", right = " "},
        },
        sections = {
            lualine_a = {"mode"},
            lualine_b = {"branch", "diagnostics"},
            lualine_c = {"filename"},
            lualine_x = {"lsp_status", "selectioncount", "searchcount", "filetype"},
            lualine_y = {"fileformat"},
            lualine_z = {"location"}
        },
    }
}
