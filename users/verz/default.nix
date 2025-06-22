{modules, ...}: {
  imports =
    [
      "${modules}/shell/zsh"
      "${modules}/shell/starship"

      "${modules}/desktop/hyprland"
      "${modules}/desktop/kanata"

      "${modules}/apps/kitty"
      "${modules}/apps/spotify"
    ]
    ++ [
      ./packages.nix
    ];

  programs.zsh.profileExtra = ''
    if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    	exec uwsm start hyprland-uwsm.desktop
    fi
  '';
}
