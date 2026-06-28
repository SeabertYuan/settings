{ inputs, pkgs, lib, config, ... }:
let
  vimPlugins = {
    seoul256 = inputs.vim_seoul256;
    fzf-vim = inputs.vim_fzf_vim;
    fzf = inputs.vim_fzf;
    vim-fugitive = inputs.vim_fugitive;
    vimtex = inputs.vim_vimtex;
    vim-sleuth = inputs.vim_sleuth;
  };
in
{
  options = {
    my.vim.package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.vim;
      description = "vim package";
    };
  };

  config = {
    home.username = "seabert";
    home.homeDirectory = "/home/seabert";

    nix = {
      package = lib.mkDefault pkgs.nix;
      settings.experimental-features = [ "nix-command" "flakes" ];
    };

    # TODO: clean this up
    programs.bash = {
      enable = true;
      shellAliases = {
        docker="podman";
        dotfiles="git --git-dir=\"$HOME/.dotfiles-git\" --work-tree=\"$HOME/.dotfiles\"";
        eww="~/builds/eww/target/release/eww";
        grep="rg";
        gt="sh ~/scripts/generate-template.sh";
        ls="ls --color=auto";
      };
      initExtra = ''
        eval "$(fzf --bash)"

        PS1='[\u@\h \W]\$ '

        PATH="~/.cargo/bin:~/.local/bin:$PATH"
        PROMPT_COMMAND='echo -ne "\033]0;''${PWD##*/}\007"'

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
      settings = {
        user = {
          email = "seabert.s.yuan23z@gmail.com";
          name = "SeabertYuan";
        };
        url = {
          "git@github.com:" = {
            insteadOf = "https://github.com/";
          };
        };
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

    programs.wezterm = {
      enable = true;
      package = inputs.wezterm.packages.${pkgs.stdenv.hostPlatform.system}.default;
    };

    home.packages = with pkgs; [
      # utilties
      fzf
      ripgrep
      yazi
      mediainfo # for a plugin for yazi
      # dev
      tmux
      neovim
      tree-sitter
    ]
    ++ (if pkgs.stdenv.isDarwin then
      [
        (vim-full.override {
          guiSupport = false;
          darwinSupport = true;
        })
      ]
    else
      [
        podman
        claude-code
        codex
        config.my.vim.package
      ]
    );

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    home.file = let inherit (inputs) dotfiles; in {
      ".config/nvim" = {
        source = "${dotfiles}/nvim";
        force = true;
      };
      ".config/tmux/tmux.conf" = {
        source = "${dotfiles}/tmux/tmux.conf";
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
      ".config/wezterm" = {
        source = "${dotfiles}/wezterm";
        recursive = true;
        force = true;
      };
      # TODO: don't hardcode this to homebrew lmao
      ".cargo/config.toml".text = ''
        [net]
        git-fetch-with-cli = true

        # [build]
        # rustc-wrapper = "/opt/homebrew/bin/sccache"
      '';
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
  };
}
