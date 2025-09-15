{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };

  # Symlink your repo into ~/.config/nvim
  xdg.configFile."nvim".source = ./nvim;
}

