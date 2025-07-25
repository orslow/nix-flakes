{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-app-util = {
      url = "github:hraban/mac-app-util";
    };

    agenix.url = "github:ryantm/agenix";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, nixvim, mac-app-util, agenix }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = [
        agenix.packages.aarch64-darwin.default
      ];

      age.identityPaths = [ "/Users/jueon/.ssh/id_ed25519" ];
      age.secrets.githubToken = {
        file = ./secrets/github_token.age;
        path = "/Users/jueon/.github_token";
        owner = "jueon";
        group = "staff";
        mode = "0400";
      };
      age.secrets.anthropicApiKey = {
        file = ./secrets/anthropic_api_key.age;
        path = "/Users/jueon/.anthropic_api_key";
        owner = "jueon";
        group = "staff";
        mode = "0400";
      };


      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      services = {};

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      # nixpkgs.config.allowBroken = true; # if need
      nixpkgs.config.allowUnfree = true; # for vault

      users.users.jueon = {
        name = "jueon";
        home = "/Users/jueon";
      };

      networking.computerName = "jueon";

      nix.settings.trusted-users = [
        "jueon"
      ];

      system = {
        primaryUser = "jueon";

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
            tilesize = 20;
            orientation = "bottom";
            autohide = false;
            magnification = true;
            largesize = 49;
            mru-spaces = false;
            show-recents = false;
            persistent-apps = [
              "/System/Cryptexes/App/System/Applications/Safari.app"
              "Applications/Firefox.app"
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
        };

        keyboard = {
            enableKeyMapping = true;
            remapCapsLockToControl = true;
        };
      };
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#jueon
    darwinConfigurations."jueon" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.sharedModules = [
            nixvim.homeManagerModules.nixvim
          ];
          users.users.jueon = {
            home = "/Users/jueon";
          };
          home-manager.users.jueon = {
            imports = [
              ./home.nix
              mac-app-util.homeManagerModules.default
            ];
          };
        }
        mac-app-util.darwinModules.default
        agenix.darwinModules.default

      ];
    };
  };
}
