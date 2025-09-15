{
  description = "NixOS + Home Manager flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
        home-manager = {
            url = "github:nix-community/home-manager/release-24.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        zen-browser = {
            url = "github:0xc000022070/zen-browser-flake";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
        mkSystem = { hostname, system, username, os }:
        nixpkgs.lib.nixosSystem {
        inherit system;
            specialArgs = { inherit inputs hostname username os; };
            modules = [
                ./modules/common/nix.nix
                ./hosts/${os}/${hostname}/hardware-configuration.nix
                ./hosts/${os}/${hostname}/configuration.nix

                home-manager.nixosModules.home-manager
                {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.backupFileExtension = "hm-bak";

                    home-manager.users.${username} = import ./users/${username}/home.nix;
                    home-manager.extraSpecialArgs = { inherit inputs hostname username os; };
                }
            ];
        };
    in
    {
      nixosConfigurations = {
        paddington = mkSystem { hostname = "paddington"; system = "x86_64-linux"; username = "shim"; os = "linux"; };
        # add more hosts here later
      };
    };
}
