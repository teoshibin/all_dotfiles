return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    config = function()
        if require("lib.os").isWindows() then
            require("nvim-treesitter.install").compilers = { "clang" }
        end
        require("nvim-treesitter").install {
            "lua", "vim", "vimdoc", "query",
            "markdown", "markdown_inline",
            "toml", "json",
            "bash",
            "html",
            "python","java", "kotlin"
        }
    end
}
