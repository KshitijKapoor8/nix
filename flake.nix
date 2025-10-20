{
  description = "NixOS + Home Manager flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:KshitijKapoor8/vim-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.nixpkgs.follows = "hyprland";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    godot_4-mono-4-3.url = "github:NixOS/nixpkgs/57cb153e9ff88c8483f81c97a75260a00333b50a";

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      zen-browser,
      nixvim,
      ...
    }@inputs:
    let
      mkSystem =
        {
          hostname,
          system,
          username,
          os,
        }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit
              inputs
              hostname
              username
              os
              ;
          };
          modules = [
            ./modules/common
            ./hosts/${os}/${hostname}/hardware-configuration.nix
            ./hosts/${os}/${hostname}/configuration.nix
            inputs.stylix.nixosModules.stylix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "hm-bak";

              home-manager.users.${username} =
                { pkgs, ... }:
                {
                  imports = [
                    ./users/${username}/home.nix
                    inputs.zen-browser.homeModules.twilight
                    inputs.niri.homeModules.niri
                  ];
                  programs.zen-browser.enable = true;
                };
              home-manager.extraSpecialArgs = {
                inherit
                  inputs
                  hostname
                  username
                  os
                  ;
              };
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        paddington = mkSystem {
          hostname = "paddington";
          system = "x86_64-linux";
          username = "shim";
          os = "linux";
        };
        nixos = mkSystem {
          hostname = "nixos";
          system = "x86_64-linux";
          username = "shim";
          os = "linux";
        };
        # add more hosts here later
      };
    };
}
