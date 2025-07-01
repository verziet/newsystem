{
  lib,
  config,
  pkgs,
  inputs,
  host,
  ...
}: let
  moduleName = "spotify";

  inherit (inputs) spicetify-nix;
  inherit (lib) mkDefault mkForce;
in {
  imports = [spicetify-nix.homeManagerModules.default];

  config = lib.mkIf config.${moduleName}.enableModule {
    programs.spicetify = let
      spicetifyPkgs = spicetify-nix.legacyPackages.${host.system};
    in {
      enable = true |> mkForce;

      enabledCustomApps = mkDefault [
        {
          # The source of the customApp
          # make sure you're using the correct branch
          # It could also be a sub-directory of the repo
          src = pkgs.fetchFromGitHub {
            owner = "spicetify";
            repo = "cli";
            rev = "main";
            hash = "sha256-2fsHFl5t/Xo7W5IHGc5FWY92JvXjkln6keEn4BZerw4=";
          };
          # The actual file name of the customApp usually ends with .js
          name = "lyrics-plus";
        }
      ];

      enabledExtensions = mkDefault (with spicetifyPkgs.extensions; [
        adblock
        hidePodcasts
        shuffle
        keyboardShortcut
      ]);

      #theme = spicetifyPkgs.themes.text |> mkDefault;
    };
  };

  options.${moduleName}.enableModule = lib.mkOption {
    description = "Enable the ${moduleName} module";
    default = true;
    type = lib.types.bool;
  };
}
