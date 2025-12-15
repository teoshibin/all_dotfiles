return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        if require("lib.os").isWindows() then
            require("nvim-treesitter.install").compilers = { "clang" }
        end

        local ts = require("nvim-treesitter")
        ts.setup({})

        -- ts.install {
        --     "lua", "vim", "vimdoc", "query",
        --     "markdown", "markdown_inline",
        --     "toml", "json",
        --     "bash",
        --     "html",
        --     "python","java", "kotlin"
        -- }

        local languages = {
            "lua", "vim", "vimdoc", "query",
            "markdown", "markdown_inline",
            "toml", "json",
            "bash",
            "html",
            "python","java", "kotlin"
        }

        vim.api.nvim_create_autocmd("UIEnter", {
            once = true,
            callback = function()
                local missing = {}
                for _, lang in ipairs(languages) do
                    if #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".*", false) == 0 then
                        table.insert(missing, lang)
                    end
                end

                if #missing == 0 then
                    return
                end

                vim.notify(
                    "Installing tree-sitter parsers: " .. table.concat(missing, ", "),
                    vim.log.levels.INFO,
                    { title = "nvim-treesitter" }
                )

                ts.install(missing)
            end,
        })
    end,
}
