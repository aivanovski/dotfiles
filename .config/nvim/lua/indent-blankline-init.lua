vim.opt.listchars:append("space:·")
vim.cmd [[highlight IndentSpaceIndent guifg=#252a32 blend=90 gui=nocombine]]
vim.cmd [[highlight NonText guifg=#252a32 gui=nocombine]]
vim.opt.list = true

local highlight = {
    "Whitespace",
}
require("ibl").setup {
    indent = { highlight = highlight, char = "" },
    whitespace = {
        highlight = highlight,
        remove_blankline_trail = false,
    },
    scope = { enabled = false },
}
