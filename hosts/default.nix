{
  lib,
  pkgs,
  inputs,
  hostname,
  host,
  ...
}: let
  inherit (lib) mkDefault mkForce mkOverride;
in {
  imports = [./${hostname}];

  networking.hostName = hostname |> mkDefault;

  users.defaultUserShell = pkgs.zsh |> mkOverride 999;
  programs.zsh.enable = true |> mkDefault;

  nix.gc = {
    automatic = true |> mkDefault;
    dates = "weekly" |> mkDefault;
    options = "--delete-older-than 1w" |> mkDefault;
  };

  users.users = lib.genAttrs host.users (username: user: {
    isNormalUser = true |> mkDefault;
    initialPassword = "" |> mkDefault;
  });

  nix = {
    channel.enable = false |> mkDefault;

    settings = {
      experimental-features = ["flakes" "nix-command" "pipe-operators"];
      flake-registry = "" |> mkDefault;

      auto-optimise-store = true |> mkDefault;

      # https://github.com/NixOS/nix/issues/9574
      nix-path = "nixpkgs=/etc/nix/inputs/nixpkgs" |> mkDefault;
    };
  };

  nixpkgs.config.allowUnfree = true |> mkDefault;
  environment = {
    variables.NIXPKGS_ALLOW_UNFREE = 1 |> mkDefault;

    etc."nix/inputs/nixpkgs".source = inputs.nixpkgs |> mkDefault;
  };

  system.stateVersion = host.stateVersion |> mkForce;
}
