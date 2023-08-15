{ wm ? null, ...}:
with builtins;
rec {
  wm = wm;

  x11-wms = ["plasma" "xmonad" "i3"];
  wayland-wms = ["hyprland" "sway"];
  wms = x11-wms ++ wayland-wms;

  # very, very non-exhaustive of course
  is-x11     = wm: elem wm x11-wms;
  is-wayland = wm: elem wm wayland-wms;
}
