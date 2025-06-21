{
  lib,
  hostname,
  host,
  username,
  ...
}: let
  inherit (lib) mkDefault mkForce;
in {
  imports = [./${username}];

  home = {
    username = username |> mkDefault;
    homeDirectory = "/home/${username}" |> mkDefault;
  };

  nixpkgs.config.allowUnfree = true |> mkDefault;

  systemd.user.startServices = "sd-switch" |> mkDefault;

  home.stateVersion = host.stateVersion |> mkForce;
}
