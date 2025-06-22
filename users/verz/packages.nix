{
  inputs,
  host,
  ...
}: {
  home.packages = [
    inputs.zen-browser.packages."${host.system}".default
  ];
}
