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
      stremio
      gemini-cli

			swww
    ]);
}
