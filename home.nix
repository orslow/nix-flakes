{ pkgs, ... }: {
  # imports = [
  #   ./configs
  # ];

  xdg.enable = true;

  home = {
    stateVersion = "25.05";

    packages = with pkgs; [
      nerd-fonts.meslo-lg
      appcleaner
      awscli2
      claude-code
      cmake
      databricks-cli
      difftastic
      dive
      duckdb
      htop
      jq
      kubectl
      kubectx
      kubernetes-helm
      # leveldb
      monitorcontrol
      rectangle
      saml2aws
      shellcheck
      sqlite
      unzip
      uv
      vault
      watch
      wget
      yq-go
      zip
    ];

    file = {
      "/Users/jueon/Library/KeyBindings/DefaultKeyBinding.dict".text = ''
        {
          "₩" = ("insertText:", "`");
        }
      '';
    };
  };

  targets = {
    darwin = {
      # https://github.com/nix-community/home-manager/issues/6120
      # keybindings = {
      #   "₩" = "`";
      #   "~\010" = "deleteWordBackward:";
      #   "~v" = "pageUp:";
      #   "^s" = "deleteWordBackward:";
      # };
    };
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
            style = "Bold";
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
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
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
        ".DS_Store"
        ".env"
        ".envrc"
        ".idea"
        ".metals"
        ".mise.toml"
        ".terraform.lock.hcl"
        ".tool-versions"
        ".venv"
        ".vscode"
        "__pycache__"
        "mise.toml"
        "out"
        "venv"
      ];
      aliases = {
        a = "add";
        aa = "add --all";
        ap = "add --patch";
        b = "branch";
        c = "commit -v";
        ca = "commit --amend";
        cane = "commit --amend --no-edit";
        co = "checkout";
        cob = "checkout -b";
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
        publish = "!f() { git push --set-upstream \${1:-origin} $(git rev-parse --abbrev-ref HEAD); }; f";
        s = "status";
        ss = "status --short";
        ssb = "status --short --branch";
        sw = "switch";
        swc = "switch -c";
      };
      extraConfig = {
        core = {
          editor = "nvim";
        };
      };
    };

    gh = {
      enable = true;
    };

    k9s = {
      enable = true;
      settings = {
        k9s = {
          refreshRate = 2;
          ui = {
            enableMouse = false;
            headless = false;
            logoless = true;
            crumbsless = false;
            reactive = false;
            noIcons = false;
            defaultsToFullScreen = false;
            skin = "light";
          };
        };
      };
      views = {
          views = {
            # "v1/pods" = {
            #   columns = [
            #     "AGE"
            #     "NAMESPACE"
            #     "NAME"
            #     "IP"
            #     "NODE"
            #     "STATUS"
            #     "READY"
            #   ];
            # };
            "v1/nodes" = {
              sortColumn = "AGE:asc";
              columns = [
                "NAME"
                "STATUS"
                "TAINTS"
                "PODS"
                "CPU"
                "MEM"
                "%CPU"
                "%MEM"
                "CPU/A"
                "MEM/A"
                "VERSION"
                "AGE"
                "INSTANCE_TYPE:.metadata.labels.node\\.kubernetes\\.io/instance-type"
                "NODEPOOL:.metadata.labels.karpenter\\.sh/nodepool"
              ];
            };
          };
      };
      skins = {
        light = {
          k9s = {
            body = {
              fgColor = "#000000";
              bgColor = "#ffffff";
              logoColor = "#268bd2";
            };
            prompt = {
              fgColor = "#000000";
              bgColor = "#ffffff";
              suggestColor = "#cb4b16";
            };
            info = {
              fgColor = "#d33682";
              sectionColor = "#000000";
            };
            dialog = {
              fgColor = "#000000";
              bgColor = "#ffffff";
              buttonFgColor = "#000000";
              buttonBgColor = "#d33682";
              buttonFocusFgColor = "white";
              buttonFocusBgColor = "#2aa198";
              labelFgColor = "#cb4b16";
              fieldFgColor = "#000000";
            };
            frame = {
              border = {
                fgColor = "#eee8d5";
                focusColor = "#000000";
              };
              menu = {
                fgColor = "#000000";
                keyColor = "#d33682";
                numKeyColor = "#d33682";
              };
              crumbs = {
                fgColor = "white";
                bgColor = "#2aa198";
                activeColor = "#b58900";
              };
              status = {
                # newColor = "#2aa198";
                newColor = "#4f4f4f";
                modifyColor = "#268bd2";
                addColor = "#859900";
                errorColor = "#dc322f";
                highlightColor = "#cb4b16";
                killColor = "#93a1a1";
                completedColor = "#93a1a1";
              };
              title = {
                fgColor = "#000000";
                bgColor = "#ffffff";
                highlightColor = "#268bd2";
                counterColor = "#d33682";
                filterColor = "#d33682";
              };
            };
            views = {
              charts = {
                bgColor = "default";
                defaultDialColors = [ "#268bd2" "#dc322f" ];
                defaultChartColors = [ "#268bd2" "#dc322f" ];
              };
              table = {
                fgColor = "#000000";
                bgColor = "#ffffff";
                cursorFgColor = "white";
                cursorBgColor = "#ffffff";
                markColor = "darkgoldenrod";
                header = {
                  fgColor = "#000000";
                  bgColor = "#ffffff";
                  sorterColor = "#2aa198";
                };
              };
              xray = {
                fgColor = "#000000";
                bgColor = "#ffffff";
                cursorColor = "#eee8d5";
                graphicColor = "#268bd2";
                showIcons = false;
              };
              yaml = {
                keyColor = "#d33682";
                colonColor = "#268bd2";
                valueColor = "#000000";
              };
              logs = {
                fgColor = "#000000";
                bgColor = "#ffffff";
                indicator = {
                  fgColor = "#000000";
                  bgColor = "#eee8d5";
                  toggleOnColor = "#d33682";
                  toggleOffColor = "#268bd2";
                };
              };
            };
          };
        };
      };
    };

    mise = {
      enable = true;
      enableZshIntegration = true;
      globalConfig = {
        tools = {
          python = [
            "3.10"
            "3.11"
            "3.12"
            "3.13"
          ];
          scala = "2.12.18";
          nodejs = "23.5.0";
          golang = "1.23.4";
          java = [
            "zulu-8.80.0.17"
          ];
          poetry = "2.1.1";
          ruby = "2.7.8";
          rust = "1.84.0";
          sbt = "1.10.7";
          terraform = "1.11.4";
        };
        settings = {
          idiomatic_version_file_enable_tools = [];
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

      colorscheme = "macvim-light";
      # colorscheme = "lunaperche";
      # colorscheme = "github_light_high_contrast";
  
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
        tabstop = 4;
        expandtab = true;
  
        # search settings
        ignorecase = true;
        smartcase = true;
      };
  
      colorschemes = {
        # modus = {
        #   enable = true;
        #   settings = {
        #     variant = "tritanopia";
        #   };
        # };
        # base16 = {
        #   enable = true;
        #   colorscheme = "google-light";
        #   setUpBar = false;
        #   settings = {
        #     telescope = true;
        #     telescope_borders = true;
        #   };
        # };
      };
  
      plugins = {
        avante = {
          enable = true;
          settings = {
            provider = "claude";
          };
        };
        copilot-lua = {
          enable = true;
          settings = {
            panel = {
              enabled = false;
            };
            suggestion = {
              enabled = false;
            };
          };
        };
        # copilot-cmp = {
        #   enable = true;
        # };
        fugitive = {
          enable = true;
        };
        gitblame = {
          enable = true;
          settings = {
            date_format = "%Y/%m/%d";
            enabled = false;
            delay = 10;
          };
        };
        gitsigns = {
          enable = true;
        };
        lualine = {
          enable = true;
          settings = {
            sections = {
              lualine_c = [
                {
                  __unkeyed-1 = "filename";
                  newfile_status = true;
                  path = 1;
                }
              ];
              lualine_x = [
                "encoding"
                "filetype"
              ];
            };
            options = {
              theme = "onelight";
              section_separators = {
                left = "";
                right = "";
              };
              component_separators = {
                left = "/";
                right = "/";
              };
            };
          };
        };
        lsp-format = {
          enable = true;
          settings = {
            typescript = {
              exclude = [
                "ts_ls"
              ];
            };
          };
        };
        lsp = {
          enable = true;
          onAttach = ''
            client.server_capabilities.semanticTokensProvider = nil
          '';
          servers = {
            gopls = {
              enable = true;
            };
            helm_ls = {
              enable = true;
              filetypes = [
                "yaml"
              ];
            };
            lua_ls = {
              enable = false;
            };
            markdown_oxide = {
              enable = true;
            };
            pyright = {
              enable = true;
            };
            rust_analyzer = {
              enable = true;
              installCargo = false;
              installRustc = false;
            };
            terraformls = {
              enable = true;
            };
            ts_ls = {
              enable = true;
            };
            yamlls = {
              enable = true;
            };
            # just use idea
            # metals = {
            #   enable = true;
            #   filetypes = ["scala" "sbt"];
            # };
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
            typescript
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
  
      extraPlugins = [
        (pkgs.vimUtils.buildVimPlugin {
          name = "vim-system-copy";
          src = pkgs.fetchFromGitHub {
              owner = "christoomey";
              repo = "vim-system-copy";
              rev = "8abd9ed21016bdc21b458c79da3b9ac0ee25c1ce";
              hash = "sha256-Z+5Kv1jzzmKSmTtswd1XIskPhmrIHTPmJ+F/gX5/TiE=";
          };
        })
        (pkgs.vimUtils.buildVimPlugin {
          name = "github-nvim-theme";
          src = pkgs.fetchFromGitHub {
              owner = "projekt0n";
              repo = "github-nvim-theme";
              rev = "c106c9472154d6b2c74b74565616b877ae8ed31d";
              hash = "sha256-/A4hkKTzjzeoR1SuwwklraAyI8oMkhxrwBBV9xb59PA=";
          };
        })
        (pkgs.vimUtils.buildVimPlugin {
          name = "macvim-light";
          src = pkgs.fetchFromGitHub {
              owner = "orslow";
              repo = "macvim-light";
              rev = "f84bb403d455820737e45a4140020ab6ae2349b5";
              hash = "sha256-z7QJobXUjvgWFBzCzYruQZQUc6cHQwUmlbGhLKgEltc=";
          };
        })
        (pkgs.vimUtils.buildVimPlugin {
          name = "vim-maximizer";
          src = pkgs.fetchFromGitHub {
              owner = "szw";
              repo = "vim-maximizer";
              rev = "2e54952fe91e140a2e69f35f22131219fcd9c5f1";
              hash = "sha256-+VPcMn4NuxLRpY1nXz7APaXlRQVZD3Y7SprB/hvNKww=";
          };
        })
      ];

      keymaps = [
        # file path copy
        {
          action = "<cmd>let @+ = expand('%')<cr>";
          key = "<leader>py";
        }
        #blame
        {
          action = "<cmd>Git blame<cr>";
          key = "<leader>gbl";
        }
        # gitblame
        {
          action = "<cmd>GitBlameToggle<cr>";
          key = "<leader>blt";
        }
        {
          action = "<cmd>GitBlameOpenCommitURL<cr>";
          key = "<leader>bloc";
        }
        {
          action = "<cmd>GitBlameOpenFileURL<cr>";
          key = "<leader>blof";
        }

        # telescope
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

        # vim-maximizer
        {
          action = "<cmd>MaximizerToggle<cr>";
          key = "<leader>z";
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

        # v to visual, y to yank
        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi y send-keys -X copy-selection # -and-cancel
        bind-key -T copy-mode-vi Enter send-keys -X copy-selection # -and-cancel
        
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

    z-lua = {
      enable = true;
      enableZshIntegration = true;
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
        rgh = "rg --hidden";
        k9s = "k9s --readonly=true";
        k9sw = "k9s --readonly=false";
      };
      history = {
        ignoreDups = false;
        # size = 10000;
        # path = "${config.xdg.dataHome}/zsh/history";
      };
      initContent = ''
        # case insensitve
        zstyle ''\':completion:*''\' matcher-list ''\'''\' ''\'m:{a-zA-Z}={A-Za-z}''\' ''\'r:|=*''\' ''\'l:|=* r:|=*''\'
        autoload -Uz compinit && compinit
        
        # bash style word selection
        autoload -U select-word-style
        select-word-style bash

        # XXX. k9s
        export K9S_CONFIG_DIR=~/.config/k9s
        export RUNEWIDTH_EASTASIAN=0
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
      path  = "$HOME/Documents/git/home-manager";
    };
  };
}
