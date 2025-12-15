local is_win = require("lib.os").isWindows()

local lsp_script = is_win
    and vim.fn.expand("~/kotlin-lsp/kotlin-lsp.cmd")
    or  vim.fn.expand("~/kotlin-lsp/kotlin-lsp.sh")

local cmd = is_win
    and { "cmd.exe", "/c", lsp_script, "--stdio" }
    or  { lsp_script, "--stdio" }

return {
    cmd = cmd,
    filetypes = { "kotlin" },
    -- root_markers = {
    --     "settings.gradle.kts",
    --     "settings.gradle",
    --     "build.gradle.kts",
    --     "build.gradle",
    --     "gradlew",
    --     ".git",
    -- },
}
