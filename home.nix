{ pkgs, ... }: {
  # imports = [
  #   ./configs
  # ];

  xdg.enable = true;

  home = {
    stateVersion = "25.05";

    packages = with pkgs; [
      nerd-fonts.meslo-lg
      anki-bin
      appcleaner
      awscli2
      blueutil
      bun
      claude-code
      databricks-cli
      dbeaver-bin
      difftastic
      dive
      duckdb
      gnumake42
      htop
      jq
      kubectl
      kubectx
      kubernetes-helm
      # leveldb
      monitorcontrol
      packer
      podman
      postgresql
      raycast
      rectangle
      saml2aws
      shellcheck
      slack
      sqlite
      tree
      unzip
      uv
      vault
      watch
      wget
      yq-go
      zip
    ];

    file = {
      "Library/KeyBindings/DefaultKeyBinding.dict".text = ''
        {
          "₩" = ("insertText:", "`");
        }
      '';
      ".claude/commands/commit.md".source = ./claude/commit.md;
      ".claude/commands/pr.md".source = ./claude/pr.md;
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
        cursor = {
          style = {
            shape = "Block";
            blinking = "Off";
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
        ".claude/"
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
        lg = "log --graph --abbrev-commit --decorate --date=short --format=format:'%C(bold blue)%h%C(reset) - %C(bold black)(%ad)%C(reset) %C(red)%s%C(reset) %C(black)- %an%C(reset)%C(blue)%d%C(reset)' --all";
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
      settings = {
        aliases = {
          rv = "repo view --web";
          pv = "pr view --web";
          pl = "pr list --web";
        };
      };
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
                "AZ:.metadata.labels.topology\\.kubernetes\\.io/zone"
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
          golang = "1.23.4";
          istioctl = "1.25.5";
          java = [
            "zulu-8.80.0.17"
          ];
          nodejs = "23.5.0";
          python = [
            "3.10"
            "3.11"
            "3.12"
            # "3.13"
            "3.12.10"
          ];
          ruby = "3.1.7";  # (25/11/12) 3.4.x not works
          rust = "1.88.0";
          sbt = "1.11.4";
          scala = "2.12.18";
          terraform = [
            "1.11.4"
            "1.12.2"
          ];
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
        copilot-lua = {
          enable = true;
          settings = {
            panel = {
              enabled = true;
            };
            suggestion = {
              enabled = true;
            };
          };
        };
        # copilot-cmp = {
        #   enable = true;
        # };
        fugitive = {
          enable = true;
        };
        fzf-lua = {
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
            options = {
              theme = {
                normal = {
                  a = { fg = "#ffffff"; bg = "#2d3748"; gui = "bold"; };
                  b = { fg = "#e2e8f0"; bg = "#4a5568"; };
                  c = { fg = "#cbd5e0"; bg = "#1a202c"; };
                };
                insert = {
                  a = { fg = "#1a202c"; bg = "#48bb78"; gui = "bold"; };
                  b = { fg = "#e2e8f0"; bg = "#4a5568"; };
                  c = { fg = "#cbd5e0"; bg = "#1a202c"; };
                };
                visual = {
                  a = { fg = "#1a202c"; bg = "#ed8936"; gui = "bold"; };
                  b = { fg = "#e2e8f0"; bg = "#4a5568"; };
                  c = { fg = "#cbd5e0"; bg = "#1a202c"; };
                };
                replace = {
                  a = { fg = "#ffffff"; bg = "#e53e3e"; gui = "bold"; };
                  b = { fg = "#e2e8f0"; bg = "#4a5568"; };
                  c = { fg = "#cbd5e0"; bg = "#1a202c"; };
                };
                command = {
                  a = { fg = "#1a202c"; bg = "#4299e1"; gui = "bold"; };
                  b = { fg = "#e2e8f0"; bg = "#4a5568"; };
                  c = { fg = "#cbd5e0"; bg = "#1a202c"; };
                };
                # inactive 는 회색/흰색 계열
                inactive = {
                  a = { fg = "#4a5568"; bg = "#f7fafc"; };
                  b = { fg = "#718096"; bg = "#edf2f7"; };
                  c = { fg = "#a0aec0"; bg = "#e2e8f0"; };
                };
              };
              globalstatus = false;
              component_separators = { left = "/"; right = "/"; };
              section_separators = { left = ""; right = ""; };
            };

            sections = {
              lualine_a = [ "mode" ];
              lualine_b = [ "branch" "diff" "diagnostics" ];
              lualine_c = [
                {
                  __unkeyed-1 = "filename";
                  newfile_status = true;
                  file_status = true;
                  path = 1;  # 0 = just filename, 1 = relative path, 2 = absolute path
                  # shorting_target = 150;
                }
              ];
              lualine_x = [ "encoding" "filetype" ];
              lualine_y = [ "progress" ];
              lualine_z = [ "location" ];
            };

            inactive_sections = {
              lualine_a = [ ];
              lualine_b = [ ];
              lualine_c = [ "filename" ];
              lualine_x = [ "location" ];
              lualine_y = [ ];
              lualine_z = [ ];
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

            -- Configure diagnostic display
            vim.diagnostic.config({
              virtual_text = {
                source = "always",
                prefix = "*",
              },
            })

            -- focus 잃었을 때와 얻었을 때 이벤트 처리
            vim.api.nvim_create_autocmd("FocusLost", {
              pattern = "*",
              callback = function()
                -- 커서 숨기기
                vim.opt.guicursor = "a:hor1-Cursor/lCursor"
                -- 또는 완전히 투명하게
                -- vim.opt.guicursor = "a:hor1-Cursor/lCursor-blinkon0"
              end,
            })

            vim.api.nvim_create_autocmd("FocusGained", {
              pattern = "*",
              callback = function()
                -- 커서 다시 보이기 (기본 설정으로 복원)
                vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"
              end,
            })
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
              enable = false;  # disable for helm
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
              # "K" = {
              #   action = "hover";
              #   desc = "Show hover information";
              # };
              # "<leader>e" = "vim.diagnostic.open_float";
              # "[d" = "vim.diagnostic.goto_prev";
              # "]d" = "vim.diagnostic.goto_next";
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
            # "<leader>fs" = "live_grep";
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
            incremental_selection = {
              enable = true;
              keymaps = {
                init_selection = false;
                node_decremental = "grm";
                node_incremental = "grn";
                scope_incremental = "grc";
              };
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
              rev = "31467ca33c56a16691cca4c3b52c263948a9c954";
              hash = "sha256-X9mG5uR+WfcJN6wFb+579O98CttfCr9rWsPP1Po0kDc=";
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
        (pkgs.vimUtils.buildVimPlugin {
          name = "claude-shuttle";
          src = pkgs.fetchFromGitHub {
              owner = "orslow";
              repo = "claude-shuttle";
              rev = "660b08a1b7063b4c3523a522d2d2b49e79b67c5d";
              hash = "sha256-gbaLHj05Y1uCaKu9guVbTZpkaFY1J+1JdFjcWmrz9zI=";
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
        # {
        #   action = "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>";
        #   key = "<leader>ff";
        # }

        # fzf-lua
        {
          action = "<cmd>FzfLua live_grep<cr>";
          key = "<leader>fs";
        }
        {
          action = "<cmd>FzfLua files<cr>";
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

    poetry = {
      enable = true;
      settings = {
        virtualenvs.create = true;
        virtualenvs.in-project = true;
      };
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

        # cursor style
        set -g cursor-style block
        set -g focus-events on
      '';
    };

    zoxide = {
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
        claude = "claude --dangerously-skip-permissions";
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

        export EDITOR=nvim
        export VISUAL=nvim

        # XXX. gh
        if [ -f ~/.github_token ]; then
            export GH_TOKEN=$(cat ~/.github_token)
        fi

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
