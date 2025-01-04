{ pkgs, ... }: {

  # imports = [
  #   ./configs
  # ];

  home = {
    stateVersion = "24.11";

    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "Meslo" ]; })
      # zip
      # unzip
      # tmux
      # spotify
      # sqlite
      # ripgrep
      # openssl
      # postgresql
      # inetutils
      # bind
      # fzf
      # difftastic
      # nushell
      # atuin
      # mpv
      # python3
      # jq
      # yq
      # qbittorrent
      # wget
      # dive
      # ffmpeg
      # kotlin
      # shellcheck
      # nixpkgs-fmt
      # gradle_7
      # texliveFull
      # pyenv

      # # kubernetes related packages
      # kubernetes-helm
      # kind

      # # password store related packages
      # gopass
      # gopass-jsonapi
      # passExtensions.pass-update

      # # macOS has pbcopy/pbpaste, nevertheless
      # xsel
      # # getting currently playing media information
      # # playerctl
    ];
  };

  programs = {
    alacritty = {
      enable = true;
      settings = {
        window = {
          padding = {
            x = 3;
            y = 3;
          };
        };
        scrolling = {
          history = 100000;
        };
        env = {
          TERM = "xterm-256color";
        };
        font = {
          size = 11;
          normal = {
            family = "MesloLGS Nerd Font";
            style = "Regular";
          };
          bold = {
            family = "MesloLGS Nerd Font";
            style = "Regular";
          };
        };
        colors = {
          primary = {
            foreground = "0x000000";
            background = "0xFFFFFF";
          };
          cursor = {
            cursor = "0x9a9a9a";
            text = "0xfffefe";
          };
          normal = {
            black = "0x000000";
            red = "0xc91b00";
            green = "0x00c200";
            yellow = "0xc7c400";
            blue = "0x0225c7";
            magenta = "0xc930c7";
            cyan = "0x00c5c7";
            white = "0xc7c7c7";
          };
          bright = {
            black = "0x000000";
            red = "0xc91b00";
            green = "0x00c200";
            yellow = "0xc7c400";
            blue = "0x0225c7";
            magenta = "0xc930c7";
            cyan = "0x00c5c7";
            white = "0xc7c7c7";
          };
        };
      };
    };

    bat = {
      enable = true;
      config = {
        pager = "less -FR";
      };
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    ripgrep = {
      enable = true;
    };

    htop = {
      enable = true;
      settings.color_scheme = 6;
    };

    tmux = {
      enable = true;
      clock24 = true;
      extraConfig = ''
        set -gu default-command
        set -g default-shell "$SHELL"

        # command by p
        unbind C-b
        set-option -g prefix C-q
        
        set -g mouse off
        
        setw -g mode-keys vi
        
        # open window with currrent path
        bind c new-window -c '#{pane_current_path}'
        
        # open panel with current path
        bind '%' split-window -h -c "#{pane_current_path}"
        bind '"' split-window -v -c "#{pane_current_path}"
        
        # set -g default-terminal screen-256color
        #set -g status-keys vi
        #setw -g mode-keys vi
        
        #set -g mouse-select-pane on
        #set -g mouse-resize-pane on
        
        # window swap off
        unbind C-o
        bind-key C-h select-pane -L
        bind-key C-l select-pane -R
        bind-key C-k select-pane -U
        bind-key C-j select-pane -D
        
        # copy-mode(for scrolling to me) re-mapping
        bind-key C-u copy-mode
        
        set-option -g renumber-windows on
        
        # vim escape time?
        set -sg escape-time 0
        
        # 256 color for p10k
        set -g default-terminal "screen-256color"
        
        # border colors
        set -g pane-active-border-style bg=default,fg=magenta
        set -g pane-border-style fg=green
        
        set-option -g history-limit 1000000
        
        # # active pane
        # set -g window-active-style 'fg=terminal,bg=terminal'
        # set -g window-style 'fg=terminal,bg=colour15' # white background
        # 
        # set-window-option -g window-status-current-style bg=white
        
        set-window-option -g window-status-current-style bg=gray
      '';
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        l = "ls -lah";
        ll = "ls -lh";
        tf = "AWS_PROFILE=saml terraform";
        k = "kubectl";
        va = ". .venv/bin/activate";
      };
      history = {
        size = 10000;
        # path = "${config.xdg.dataHome}/zsh/history";
      };
      initExtra = ''
        # source ~/.p10k.zsh
        # source ~/.p10k.zsh-theme
  
        # case insensitve
        zstyle ''\':completion:*''\' matcher-list ''\'''\' ''\'m:{a-zA-Z}={A-Za-z}''\' ''\'r:|=*''\' ''\'l:|=* r:|=*''\'
        autoload -Uz compinit && compinit
        
        # bash style word selection
        autoload -U select-word-style
        select-word-style bash
      '';
  
      plugins = [
        {
          name = "powerlevel10k-config";
          src = ./scripts;
          file = "p10k.zsh";
        }
        {                                                                                   
          name = "powerlevel10k";                                                           
          src = pkgs.zsh-powerlevel10k;                                                     
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";                         
        }
      ];
    };
    nixvim = {
      enable = true;
      viAlias = true;

      globals = {
        mapleader = " ";
      };
  
      opts = {
        startofline = true;
        number = true;
        relativenumber = true;
        cursorline = true;
        scrolloff = 4;
        termguicolors = true;
        background = "light";
        signcolumn = "yes";
        mouse = "r";
        splitright = true;
        splitbelow = true;
  
        # tab
        expandtab = true;
  
        # search settings
        ignorecase = true;
        smartcase = true;
      };
  
      colorschemes = {
        base16 = {
          enable = true;
          colorscheme = "google-light";
        };
        # modus = {
        #   enable = true;
        #   settings = {
        #   };
        # };
      };
  
      plugins = {
        lsp-format = {
          enable = true;
        };
        lsp = {
          enable = true;
          servers = {
            pyright = {
              enable = true;
            };
            metals = {
              enable = true;
              filetypes = ["scala" "sbt"];
            };
            gopls = {
              enable = true;
            };
            terraformls = {
              enable = true;
            };
            lua_ls = {
              enable = false;
            };
            yamlls = {
              enable = true;
            };
            markdown_oxide = {
              enable = true;
            };
          };
          keymaps = {
            lspBuf = {
              gd = {
                action = "definition";
                desc = "Goto Definition";
              };
              gr = {
                action = "references";
                desc = "Goto References";
              };
              gD = {
                action = "declaration";
                desc = "Goto Declaration";
              };
              gI = {
                action = "implementation";
                desc = "Goto Implementation";
              };
              gT = {
                action = "type_definition";
                desc = "Type Definition";
              };
              "<leader>cr" = {
                action = "rename";
                desc = "Rename";
              };
            };
          };
        };
  
        nvim-tree = {
          enable = true;
          hijackCursor = true;
          modified = {
            enable = true;
          };
          extraOptions = {
          };
        };
        web-devicons = {
          enable = true;
        };
  
        telescope = {
          enable = true;
          keymaps = {
            "<leader>fs" = "live_grep";
            "<leader>fc" = "grep_string";
            "<leader>fb" = "buffers";
            "<leader>fh" = "help_tags";
          };
        };
        
        treesitter = {
          enable = true;
  
          settings = {
            indent = {
              enable = false;
            };
            highlight = {
              enable = true;
            };
          };
        };
        
        cmp = {
          enable = true;
          autoEnableSources = true;
          # sources = [
          #   {
          #     name = "nvim_lsp";
          #   }
          # ];
        };
        luasnip = {
          enable = true;
        };
        
      };
  
      extraPlugins = [(pkgs.vimUtils.buildVimPlugin {
        name = "vim-system-copy";
        src = pkgs.fetchFromGitHub {
            owner = "christoomey";
            repo = "vim-system-copy";
            rev = "8abd9ed21016bdc21b458c79da3b9ac0ee25c1ce";
            hash = "sha256-Z+5Kv1jzzmKSmTtswd1XIskPhmrIHTPmJ+F/gX5/TiE=";
        };
      })];
      keymaps = [
        {
          action = "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>";
          key = "<leader>ff";
        }

        # nvim-tree
        {
          action = "<cmd>NvimTreeToggle<cr>";
          key = "<leader>et";
        }
        {
          action = "<cmd>NvimTreeFocus<cr>";
          key = "<leader>ef";
        }
      ];
    };

    home-manager = {
      enable = true;
    };
  };
}
