{ pkgs, ... }:
{
  programs.nvf = {
    enable = false;

    settings = {
      vim.viAlias = true;
      vim.vimAlias = true;

      vim.lsp = {
        enable = true;
      };

      vim.theme = {
        enable = true;
        name = "gruvbox";
        style = "dark";
      };

      vim = {
        statusline.lualine.enable = true;
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;

        languages = {
          enableLSP = true;
          enableTreesitter = true;
          nix.enable = true;
          ts.enable = true;
          rust.enable = true;
        };

        dashboard = {
          dashboard-nvim.enable = true;
        };
      };
    };
  };
}

