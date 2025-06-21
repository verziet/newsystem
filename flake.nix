{
  description = ''
    my super duper flake
  ''; #TODO

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts/main";

		hyprland.url = "github:hyprwm/hyprland/main";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];

      perSystem = {pkgs, ...}: {
        formatter = pkgs.alejandra;
      };

      flake = let
        meta = import ./meta.nix;

        inherit (inputs.nixpkgs) lib;
      in {
        nixosConfigurations =
          meta.hosts
          |> lib.mapAttrs (
            hostname: host:
              lib.nixosSystem {
                system = host.system;
                modules = [./hosts];

                specialArgs = {
                  inherit lib inputs host hostname;
                  modules = ./modules/system;
                };
              }
          );
      };
    };
}
