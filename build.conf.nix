with builtins;
{
  wm = "kde";

  is-x11 = wm: elem wm ["kde" "xmonad"];
}
