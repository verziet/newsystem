{
  description = ''
    my super duper flake
  ''; #TODO

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts/main";

    hyprland.url = "github:hyprwm/hyprland/main";
  };

  outputs = {nixpkgs, ...} @ inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];

      perSystem = {pkgs, ...}: {
        formatter = pkgs.alejandra;
      };

      flake = let
        meta = import ./meta.nix;

        inherit (nixpkgs) lib;
      in {
        nixosConfigurations =
          meta.hosts
          |> lib.mapAttrs (
            hostname: host:
              lib.nixosSystem {
                system = host.system;
                modules = [./hosts];

                specialArgs = {
                  inherit lib inputs hostname host;
                  modules = ./modules/system;
                };
              }
          );

        homeConfigurations =
          meta.hosts
          |> lib.foldlAttrs (
            _: hostname: host:
              lib.listToAttrs (
                host.users
                |> lib.map (
                  username: {
                    name = "${username}@${hostname}";
                    value = inputs.home-manager.lib.homeManagerConfiguration {
                      pkgs = nixpkgs.legacyPackages.${host.system};
                      modules = [./users];

                      extraSpecialArgs = {
                        inherit inputs hostname host username;
                        modules = ./modules/user;
                      };
                    };
                  }
                )
              )
          )
          null;
      };
    };
}
