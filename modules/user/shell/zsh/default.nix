{
  lib,
  config,
  pkgs,
  ...
}: let
  moduleName = "zsh";

  inherit (lib) mkDefault mkForce;
in {
  config = lib.mkIf config.${moduleName}.enableModule {
    programs.zsh = {
      enable = true |> mkForce;

      syntaxHighlighting.enable = true |> mkDefault;

      shellAliases = lib.mkMerge [
        {
          l = "ls -l";
          ll = "ls -l -A";
          g = "git";
        }
        #(lib.mkIf config."bat".enableModule {
        #  cat = "bat -p";
        #})
      ];

      initContent = lib.readFile ./zshrc;

      history = {
        extended = true |> mkDefault;
        path = "${config.xdg.dataHome}/zsh/history" |> mkDefault;
        size = 10000 |> mkDefault;
      };
    };

    # for commands in zshrc
    home.packages = with pkgs; [
      nh
    ];
  };

  options.${moduleName}.enableModule = lib.mkOption {
    description = "Enable the ${moduleName} module";
    default = true;
    type = lib.types.bool;
  };
}
