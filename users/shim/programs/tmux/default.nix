{ pkgs, ... }:
{
  programs.fzf.tmux.enableShellIntegration = true;

  programs.sesh.enable = true;

  programs.tmux = {
    enable = true;

    shell = "${pkgs.zsh}/bin/zsh";

    terminal = "tmux-256color";

    mouse = true;
    keyMode = "vi";

    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.resurrect
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @resurrect-capture-pane-contents "on"
          set -g @continuum-restore "on"
        '';
      }
      tmuxPlugins.continuum
      {
        plugin = tmuxPlugins.tmux-sessionx;
        extraConfig = ''
          set -g @sessionx-bind 'k'
          set -g @sessionx-window-height '70%'
          set -g @sessionx-window-width '55%'
          set -g @sessionx-prompt '❄ '
        '';
      }
      # {
      #   plugin = tmuxPlugins.catppuccin;
      # }
    ];

    shortcut = "s";

    extraConfig = builtins.readFile ./tmux.conf;
  };
}
