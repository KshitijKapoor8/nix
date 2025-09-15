return {
    {
        "let-def/texpresso.vim",
    },
    {
        "lervag/vimtex",
        lazy = false, -- start immediately for .tex buffers
        init = function()
            -- Compiler
            vim.g.vimtex_compiler_method = "latexmk"
            vim.g.vimtex_compiler_latexmk = {
                options = { "-pdf", "-interaction=nonstopmode", "-synctex=1" },
            }
            -- Viewer: Skim (macOS) or zathura (Linux)
            vim.g.vimtex_view_method = "skim"
            -- For inverse search with neovim-remote:
            vim.g.vimtex_compiler_progname = "nvr" -- requires `pip install neovim-remote`
        end,
    },
}
