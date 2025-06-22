{modules, ...}: {
  imports = [
    "${modules}/shell/zsh"
    "${modules}/shell/starship"

    "${modules}/desktop/hyprland"
    "${modules}/desktop/kanata"

    "${modules}/apps/kitty"
    "${modules}/apps/spotify"
  ];
}
