{modules, ...}: {
  imports = [
    "${modules}/shell/zsh"
    "${modules}/shell/starship"

    "${modules}/apps/kitty"
    "${modules}/apps/spotify"
  ];
}
