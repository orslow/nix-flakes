{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/main";
      # inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs =
    {
      self,
      nix-darwin,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      nixvim,
      agenix,
      fenix,
    }:
    let
      username = "jueon";
      homeDir = "/Users/${username}";

      mkDarwinConfig =
        { hostName }:
        nix-darwin.lib.darwinSystem {
          modules = [
            (
              { pkgs, ... }:
              {
                # List packages installed in system profile. To search by name, run:
                # $ nix-env -qaP | grep wget
                environment.systemPackages = [
                  agenix.packages.aarch64-darwin.default
                ];

                age.identityPaths = [ "${homeDir}/.ssh/id_ed25519" ];
                age.secrets.githubToken = {
                  file = ./secrets/github_token.age;
                  path = "${homeDir}/.github_token";
                  owner = username;
                  group = "staff";
                  mode = "0400";
                };

                # Necessary for using flakes on this system.
                nix.settings.experimental-features = "nix-command flakes";

                # Enable alternative shell support in nix-darwin.
                # programs.fish.enable = true;

                services = { };

                # Set Git commit hash for darwin-version.
                system.configurationRevision = self.rev or self.dirtyRev or null;

                # Used for backwards compatibility, please read the changelog before changing.
                # $ darwin-rebuild changelog
                system.stateVersion = 5;

                # The platform the configuration will be used on.
                nixpkgs.hostPlatform = "aarch64-darwin";

                # nixpkgs.config.allowBroken = true; # if need
                nixpkgs.config.allowUnfree = true; # for vault

                users.users.${username} = {
                  name = username;
                  home = homeDir;
                };

                networking.computerName = hostName;

                nix.settings.trusted-users = [
                  username
                ];

                system = {
                  primaryUser = username;

                  defaults = {
                    finder = {
                      FXPreferredViewStyle = "clmv";
                      NewWindowTarget = "OS volume";
                      ShowExternalHardDrivesOnDesktop = false;
                      ShowRemovableMediaOnDesktop = false;
                      ShowPathbar = true;
                    };
                    hitoolbox.AppleFnUsageType = "Do Nothing";

                    dock = {
                      tilesize = 18;
                      orientation = "bottom";
                      autohide = false;
                      magnification = true;
                      largesize = 49;
                      mru-spaces = false;
                      show-recents = false;
                      persistent-apps = [
                        "/System/Cryptexes/App/System/Applications/Safari.app"
                        # "Applications/Firefox.app"
                        # "/nix/store/3738cddylymymrp3kpfaz41768ld8ilz-firefox-145.0.1/Applications/Firefox.app"
                        "${homeDir}/Applications/Home Manager Apps/Firefox.app"
                        "/System/Applications/Music.app"
                        "/System/Applications/Notes.app"
                        "/System/Applications/Reminders.app"
                        "/System/Applications/Calendar.app"
                      ];
                    };

                    loginwindow = {
                      GuestEnabled = false;
                    };

                    NSGlobalDomain = {
                      InitialKeyRepeat = 15;
                      KeyRepeat = 2;
                      ApplePressAndHoldEnabled = false;
                      NSAutomaticCapitalizationEnabled = false;
                      NSAutomaticDashSubstitutionEnabled = false;
                      NSAutomaticInlinePredictionEnabled = false;
                      NSAutomaticPeriodSubstitutionEnabled = false;
                      NSAutomaticQuoteSubstitutionEnabled = false;
                      NSAutomaticSpellingCorrectionEnabled = false;
                      AppleSpacesSwitchOnActivate = false;
                      "com.apple.trackpad.scaling" = 1.8;
                    };

                    SoftwareUpdate = {
                      AutomaticallyInstallMacOSUpdates = false;
                    };

                    trackpad = {
                      ActuationStrength = 0;
                      Clicking = true;
                      FirstClickThreshold = 0;
                      TrackpadThreeFingerTapGesture = 2;
                    };

                    menuExtraClock = {
                      Show24Hour = true;
                      ShowSeconds = true;
                    };

                    WindowManager = {
                      EnableStandardClickToShowDesktop = false;
                    };

                    controlcenter = {
                      FocusModes = true;
                    };
                  };
                };
              }
            )
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.sharedModules = [
                nixvim.homeModules.nixvim
              ];
              users.users.${username} = {
                home = homeDir;
              };
              home-manager.users.${username} = {
                imports = [
                  ./home.nix
                  # mac-app-util.homeManagerModules.default
                ];
              };
              home-manager.extraSpecialArgs = {
                pkgs-unstable = import nixpkgs-unstable {
                  system = "aarch64-darwin";
                  config.allowUnfree = true;
                };
                fenixPkgs = fenix.packages.aarch64-darwin;
              };
            }
            # mac-app-util.darwinModules.default
            agenix.darwinModules.default

          ];
        };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#jueon
      darwinConfigurations = {
        "jueon" = mkDarwinConfig { hostName = "jueon"; };
        "jueon-macmini" = mkDarwinConfig { hostName = "jueon-macmini"; };
      };

      # packages.aarch64-darwin.default = fenix.packages.aarch64-darwin.minimal.toolchain;
      # nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      #   system = "aarch64-darwin";
      #   modules = [
      #     ({ pkgs, ... }: {
      #       nixpkgs.overlays = [ fenix.overlays.default ];
      #       environment.systemPackages = [
      #         (pkgs.fenix.complete.withComponents [
      #           "cargo"
      #           "clippy"
      #           "rust-src"
      #           "rustc"
      #           "rustfmt"
      #         ])
      #         pkgs.rust-analyzer-nightly
      #       ];
      #     })
      #   ];
      # };

      # # 프로젝트 devShell 템플릿
      # # $ nix flake init -t ~/.config/nix-flakes#rust
      # templates = {
      #   rust = {
      #     path = ./templates/rust;
      #     description = "Rust devShell pinned by rust-toolchain.toml (rust-overlay + direnv)";
      #   };
      # };
    };
}
