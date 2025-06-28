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
          gs = "git status";
          ga = "git add";
          gat = "git add --update";
          gr = "git restore";
          grs = "git restore --staged";
          gc = "git commit";
          gp = "git push";
          gl = "git pull";
          gb = "git branch";
          gco = "git checkout";
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
