{
  description = "Example nix-darwin system flake";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-app-util = {
      url ="github:hraban/mac-app-util";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, nixvim, mac-app-util }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ pkgs.vim
        ];

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
      users.users.jueoneya = {
        name = "jueoneya";
        home = "/Users/jueoneya";
      };

      networking.computerName = "jueoneya";

      nix.settings.trusted-users = [
        "jueoneya"
      ];

      system = {
        defaults = {
          finder = {
            ShowPathbar = true;
            FXPreferredViewStyle = "clmv";
            ShowExternalHardDrivesOnDesktop = false;
            ShowHardDrivesOnDesktop = false;
            ShowMountedServersOnDesktop = false;
            ShowRemovableMediaOnDesktop = false;
          };

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
          CustomUserPreferences = {
            "com.apple.screencapture" = {
              location = "~/Documents/screenshots";
              type = "png";
            };
          };

          # NSGlobalDomain = {
          #   InitialKeyRepeat = 2;
          #   KeyRepeat = 3;
          # };

          SoftwareUpdate = {
            AutomaticallyInstallMacOSUpdates = false;
          };
          
          trackpad = {
            Clicking = true;
            ActuationStrength = 0;
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
    # $ darwin-rebuild build --flake .#jueoneya
    darwinConfigurations."jueoneya" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration

        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.sharedModules = [
            nixvim.homeManagerModules.nixvim
          ];
          users.users.jueoneya = {
            home = "/Users/jueoneya";
          };
          home-manager.users.jueoneya = {
            imports = [
              ./home.nix
              mac-app-util.homeManagerModules.default
            ];
          };
        }
        mac-app-util.darwinModules.default
      ];
    };
  };
}
