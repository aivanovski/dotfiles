vim.opt.listchars:append("space:·")
vim.cmd [[highlight IndentSpaceIndent guifg=#252a32 blend=90 gui=nocombine]]
vim.cmd [[highlight NonText guifg=#252a32 gui=nocombine]]
vim.opt.list = true

require("indent_blankline").setup {
    space_char_blankline = " ",
    space_char_highlight_list = {
        "IndentSpaceIndent",
    },
    show_trailing_blankline_indent = false,
    use_treesitter = true,
    enabled = false
}
