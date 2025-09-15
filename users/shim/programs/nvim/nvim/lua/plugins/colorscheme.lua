return {
    -- add gruvbox
    { "ellisonleao/gruvbox.nvim" },

    {
        "catppuccin",
        opts = {
            transparent_background = true,
        },
    },

    -- Configure LazyVim to load gruvbox
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "catppuccin-mocha",
        },
    },
}
