with builtins;
{
  wm = "xmonad";

  # very, very non-exhaustive of course
  is-x11     = wm: elem wm ["kde" "xmonad"];
  is-wayland = wm: elem wm ["hyprland" "sway"];
}
