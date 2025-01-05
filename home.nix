{ pkgs, ... }: {
  # imports = [
  #   ./configs
  # ];

  home = {
    stateVersion = "24.11";

    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "Meslo" ]; })
      awscli
      bat
      difftastic
      direnv
      dive
      htop
      k9s
      # kanata # https://github.com/NixOS/nixpkgs/issues/366356
      karabiner-elements
      # keyd # not support aarch64-darwin
      kubectl
      kubernetes-helm
      openssl
      poetry
      postgresql
      saml2aws
      shellcheck
      sqlite
      unzip
      vault
      wget
      yq
      z-lua
      zip
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

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    git = {
      enable = true;
      userEmail = "juuueon@gmail.com";
      userName = "Jueon Park";
      ignores = [
        ".env"
        ".venv"
        "venv"
        ".idea"
        ".metals"
        ".vscode"
        ".tool-versions"
        "mise.toml"
      ];
      aliases = {
        a = "add";
        aa = "add --all";
        b = "branch";
        c = "commit -v";
        ca = "commit --amend";
        cane = "commit --amend --no-edit";
        co = "checkout";
        cp = "cherry-pick";
        d = "diff";
        f = "fetch";
        l = "log";
        lg = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(magenta)%s%C(reset) %C(green)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
        lgpt = "log --pretty=format:'%h %s' --graph";
        lo = "log --oneline";
        lol = "log --graph --decorate --pretty=oneline --abbrev-commit";
        lola = "log --graph --decorate --pretty=oneline --abbrev-commit --all";
        pl = "pull";
        pr = "pull --rebase";
        s = "status";
        ss = "status --short";
        sw = "switch";
        ssb = "status --short --branch";
      };
      extraConfig = {
        # Sign all commits using ssh key
        commit.gpgsign = true;
        gpg.format = "ssh";
        user.signingkey = "~/.ssh/id_ed25519.pub";
      };
    };

    mise = {
      enable = true;
      globalConfig = {
        tools = {
          python = [
            "3.10"
            "3.11"
            "3.12"
          ];
          scala = "2.12.18";
          nodejs = "23.5.0";
          golang = "1.23.4";
          java = [
            "zulu-8.80.0.17"
          ];
          ruby = "2.7.8";
          terraform = [
            "1.10.3"
          ];
        };
      };
    };

    nixvim = {
      enable = true;
      viAlias = true;

      globals = {
        mapleader = " ";
        loaded_netrw = 1;
        loaded_netrwPlugin = 1;
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
            # just use idea
            # metals = {
            #   enable = true;
            #   filetypes = ["scala" "sbt"];
            # };
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
            renderer = {
              full_name = true;
              indent_markers = {
                enable = false;
              };
              icons = {
                git_placement = "signcolumn";
                show = {
                  file = true;
                  folder = false;
                  folder_arrow = true;
                  git = true;
                };
              };
            };
            actions = {
              open_file = {
                resize_window = true;
                window_picker = {
                  enable = false;
                };
              };
            };
            view = {
              # adaptive_size = true;
              width = "15%";
              side = "left";
            };
            update_focused_file = {
              enable = true;
              update_root = true;
            };
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

          grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
            bash
            lua
            make
            markdown
            nix
            regex
            vim
            vimdoc
            xml
            json
            yaml
            toml
            c
            cpp
            python
            scala
            go
            terraform
          ];
  
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
          settings = {
            sources = [
              { name = "nvim_lsp"; }
              { name = "path"; }
              { name = "buffer"; }
            ];
            mapping = {
              # "<C-Space>" = "cmp.mapping.complete()";
              "<C-d>" = "cmp.mapping.scroll_docs(-4)";
              "<C-e>" = "cmp.mapping.close()";
              "<C-f>" = "cmp.mapping.scroll_docs(4)";
              "<CR>" = "cmp.mapping.confirm({ select = true })";
              "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
              "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            };
          };
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

    ripgrep = {
      enable = true;
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
        k = "kubectl";
        tf = "AWS_PROFILE=saml terraform";
        va = ". .venv/bin/activate";
      };
      history = {
        size = 10000;
        # path = "${config.xdg.dataHome}/zsh/history";
      };
      initExtra = ''
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

    home-manager = {
      enable = true;
    };
  };
}
