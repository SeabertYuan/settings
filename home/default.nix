{ config, pkgs, dotfiles, ... }:
let
  vimPlugins = {
    seoul256 = builtins.fetchGit {
      url = "https://github.com/junegunn/seoul256.vim";
      rev = "d9a91d8d4e153274e1ecc0ceb05c37f0d0de84d7";
    };
    fzf-vim = builtins.fetchGit {
      url = "https://github.com/junegunn/fzf.vim";
      rev = "ddc14a6a5471147e2a38e6b32a7268282f669b0a";
    };
    fzf = builtins.fetchGit {
      url = "https://github.com/junegunn/fzf";
      rev = "2ab923f3ae04d5e915e5ff4a9cd3bd515bfd1ea5";
      ref = "refs/tags/0.67.0";
    };
    vim-fugitive = builtins.fetchGit {
      url = "https://github.com/tpope/vim-fugitive";
      rev = "61b51c09b7c9ce04e821f6cf76ea4f6f903e3cf4";
    };
    vimtex = builtins.fetchGit {
      url = "https://github.com/lervag/vimtex";
      rev = "2e1bbabeb2c34bb17d7bc8cfdf8f95b16dd0db0c";
    };
    vim-sleuth =  builtins.fetchGit {
      url = "https://github.com/tpope/vim-sleuth";
      rev = "be69bff86754b1aa5adcbb527d7fcd1635a84080";
    };
  };
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "seabert";
  home.homeDirectory = "/home/seabert";

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      ls="ls --color=auto";
      grep="rg";
      gt="sh ~/scripts/generate-template.sh";
      eww="~/builds/eww/target/release/eww";
      dotfiles="git --git-dir=\"$HOME/.dotfiles-git\" --work-tree=\"$HOME/.dotfiles\"";
    };
    initExtra = ''
      eval "$(fzf --bash)"

      PS1='[\u@\h \W]\$ '

      PATH="~/.local/bin:$PATH"

      # to allow yazi to exit into selected file path
      function yy() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
          cd -- "$cwd"
        fi
        rm -f -- "$tmp"
      }
    '';
  };

  programs.git = {
    enable = true;
    lfs.enable = true;
    settings.user = {
      mail = "seabert.s.yuan23z@gmail.com";
      name = "SeabertYuan";
    };
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.

  home.packages = with pkgs; [
    # utilties
    fzf
    ripgrep
    yazi
    mediainfo # for a plugin for yazi
    # dev
    vim-full
    tmux
    neovim
    tree-sitter
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/nvim" = {
      source = "${dotfiles}/nvim";
      force = true;
    };
    ".config/tmux" = {
      source = "${dotfiles}/tmux";
      force = true;
    };
    ".config/yazi" = {
      source = "${dotfiles}/yazi";
      force = true;
    };
    ".vimrc".source = "${dotfiles}/.vimrc";
    ".vim/pack/colours/start/seoul256.vim" = {
      source = vimPlugins.seoul256;
      recursive = true;
    };
    ".vim/pack/utils/start/fzf" = {
      source = vimPlugins.fzf;
      recursive = true;
    };
    ".vim/pack/utils/start/fzf.vim" = {
      source = vimPlugins.fzf-vim;
      recursive = true;
    };
    ".vim/pack/utils/start/fugitive.vim" = {
      source = vimPlugins.vim-fugitive;
      recursive = true;
    };
    ".vim/pack/utils/start/vimtex" = {
      source = vimPlugins.vimtex;
      recursive = true;
    };
    ".vim/pack/utils/start/sleuth.vim" = {
      source = vimPlugins.vim-sleuth;
      recursive = true;
    };
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/seabert/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "vim";
    FZF_DEFAULT_OPTS="--reverse";
    SUDO_EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
