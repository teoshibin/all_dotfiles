return {
    -- NOTE: https://github.com/glacambre/firenvim
    "glacambre/firenvim",
    build = ":call firenvim#install(0)",
    cond = vim.g.started_by_firenvim == true
}
