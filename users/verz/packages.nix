{
  pkgs,
  inputs,
  host,
  ...
}: {
  home.packages =
    [
      inputs.zen-browser.packages."${host.system}".default
    ]
    ++ (with pkgs; [
      gemini-cli
      stremio
    ]);
}
