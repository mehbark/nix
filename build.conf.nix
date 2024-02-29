input@{ wm ? null, ...}:
with builtins;
input //
rec {
  # should probably split plasma into plasma-x11 and plasma-wayland at some point
  # not all of these actually work btw
  x11-wms = ["xmonad" "i3"];
  #                                 v :o v
  wayland-wms = ["hyprland" "sway" "plasma"];
  wms = x11-wms ++ wayland-wms;

  # very, very non-exhaustive of course
  is-x11     = elem wm x11-wms;
  is-wayland = elem wm wayland-wms;
}
