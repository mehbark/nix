with builtins;
{
  wm = "plasma";

  # very, very non-exhaustive of course
  is-x11     = wm: elem wm ["plasma" "xmonad"];
  is-wayland = wm: elem wm ["hyprland" "sway"];
}
