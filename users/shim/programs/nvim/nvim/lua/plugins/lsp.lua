-- Disable Mason and use system (Nix) LSP binaries
return {
  { "williamboman/mason.nvim", enabled = false },
  { "williamboman/mason-lspconfig.nvim", enabled = false },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- These names must match what you installed via nixpkgs
        clangd = { cmd = { vim.fn.exepath("clangd") } },
        rust_analyzer = { cmd = { vim.fn.exepath("rust-analyzer") } },
        taplo = { cmd = { vim.fn.exepath("taplo") } },
        lua_ls = { cmd = { vim.fn.exepath("lua-language-server") } },
      },
    },
  },
}
