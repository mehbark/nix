# https://pastebin.com/AreP6tnU;
rec {
  colors = {
    background = "#121212";
    background-alt = "#282828";

    foreground = "#f9f5d7";
    foreground-alt = "#7c6f64";
    primary = "#ffb52a";
    secondary = "#e60053";
    alert = "#cc241d";
  };

  bar.primary = {
    width = "100%";
    height = "26";

    radius = "0.0";
    fixed-center = "true";
    bottom = "true";

    background = "${colors.background}";
    foreground = "${colors.foreground}";

    line-size = "0";
    line-color = "#f00";

    border-size = "0";
    border-color = "#a89984";

    padding-left = "2";
    padding-right = "2";

    module-margin-left = "1";
    module-margin-right = "1";

    "#font-0" = "fixed:pixelsize=9";
    "#font-1" = "unifont:fontformat=truetype:size=8:antialias=false";
    "#font-2" = "siji:pixelsize=10";
    "#font-3" = "Material Icons:size=13";
    "#font-4" = "Font Awesome 5 Free Solid:size=10";
    "#font-5" = "Font Awesome 5 Free Regular:size=10";
    "#font-6" = "Font Awesome 5 Brands:size=11";
    "#font-7" = "Material-Design-Iconic-Font:size=13";
    font-0 = "Plex Custom:size=9.5";
    font-1 = "Material\\-Design\\-Iconic\\-Font:size=12";
    font-2 = "Font Awesome 5 Free Solid:size=10";
    font-3 = "Font Awesome 5 Free Regular:size=10";
    font-4 = "BlexMono NF:size=14";
    font-5 = "Font Awesome 5 Brands:size=11";

    modules-left = "time memory cpu mpd";
    modules-center = "i3";
    modules-right = "battery pulseaudio wlan eth";

    tray-position = "right";
    tray-padding = "3";
    tray-background = "${colors.background}";
    tray-maxsize = "22";
    tray-scale = "1.1";

    wm-restack = "i3";

    cursor-click = "pointer";
    cursor-scroll = "ns-resize";

    enable-ipc = "true";
  };

  bar.secondary = {
    width = "100%";
    height = "25";

    radius = "0.0";
    fixed-center = "true";
    bottom = "true";

    background = "${colors.background}";
    foreground = "${colors.foreground}";

    line-size = "0";
    line-color = "#f00";

    border-size = "0";

    border-color = "#a89984";

    padding-left = "3";
    padding-right = "3";

    module-margin-left = "1";
    module-margin-right = "1";

    font-0 = "Plex Custom:size=9.5";
    font-1 = "Material-Design-Iconic-Font:size=13";
    font-2 = "Font Awesome 5 Free Solid:size=10";
    font-3 = "Font Awesome 5 Free Regular:size=10";
    font-4 = "BlexMono NF:size=14";
    font-5 = "Font Awesome 5 Brands:size=11";

    modules-left = "time memory cpu mpd";
    modules-center = "i3";
    modules-right = "battery pulseaudio wlan eth";

    tray-position = "none";

    wm-restack = "i3";

    cursor-click = "pointer";
    cursor-scroll = "ns-resize";

    enable-ipc = "true";
  };

  module.xkeyboard = {
    type = "internal/xkeyboard";
    blacklist-0 = "num lock";

    format-prefix = " ";
    format-prefix-foreground = "${colors.foreground-alt}";
    format-prefix-underline = "${colors.secondary}";

    label-layout = "%layout%";
    label-layout-underline = "${colors.secondary}";

    label-indicator-padding = "2";
    label-indicator-margin = "1";
    label-indicator-background = "${colors.secondary}";
    label-indicator-underline = "${colors.secondary}";
  };

  module.filesystem = {
    type = "internal/fs";
    interval = "25";

    mount-0 = "/";

    label-mounted = "%{F#0a81f5}%mountpoint%%{F-}: %percentage_used%%";
    label-unmounted = "%mountpoint% not mounted";
    label-unmounted-foreground = "${colors.foreground-alt}";
  };

  module.bspwm = {
    type = "internal/bspwm";

    label-focused = "%index%";
    label-focused-background = "${colors.background-alt}";
    label-focused-underline= "${colors.primary}";
    label-focused-padding = "2";

    label-occupied = "%index%";
    label-occupied-padding = "2";

    label-urgent = "%index%!";
    label-urgent-background = "${colors.alert}";
    label-urgent-padding = "2";

    label-empty = "%index%";
    label-empty-foreground = "${colors.foreground-alt}";
    label-empty-padding = "2";
  };

  module.i3 = {
    type = "internal/i3";
    format = "<label-state> <label-mode>";
    index-sort = "true";
    wrapping-scroll = "false";

    pin-workspaces = "true";

    label-mode-padding = "1";
    label-mode-foreground = "#000";
    label-mode-background = "${colors.primary}";

    label-focused = "%index%";
    label-focused-background = "${colors.background-alt}";
    label-focused-foreground = "${colors.foreground}";
    label-focused-underline= "${colors.primary}";
    label-focused-padding = "1";

    label-unfocused = "%index%";
    label-unfocused-padding = "1";

    label-visible = "%index%";
    label-visible-background = "${self.label-focused-background}";
    label-visible-foreground = "${self.label-focused-foreground}";
    label-visible-underline = "${self.label-focused-underline}";
    label-visible-padding = "${self.label-focused-padding}";

    label-urgent = "%index%";
    label-urgent-background = "${colors.alert}";
    label-urgent-padding = "1";
  };

  module.mpd = {
    type = "internal/mpd";
    label-song-background = "${colors.foreground}";
    label-song-foreground = "${colors.background}";

    label-song-padding = "1";
    format-playing = "<label-song>  <icon-prev>  <toggle>  <icon-stop>  <icon-next>";
    format-paused = "<label-song>  <icon-prev>  <toggle>  <icon-stop>  <icon-next>";
    format-stopped = "";
    label-song = "ﱘ %title%";

    port=6000;

    icon-prev = "";
    icon-stop = "";
    icon-play = "";
    icon-pause = "";
    icon-next = "";

    label-song-maxlen = "15";
    label-song-ellipsis = "true";
  };

  module.xbacklight = {
    type = "internal/xbacklight";

    format = "<label> <bar>";
    label = "BL";

    bar-width = "10";
    bar-indicator = "|";
    bar-indicator-foreground = "#fff";
    bar-indicator-font = "2";
    bar-fill = "─";
    bar-fill-font = "2";
    bar-fill-foreground = "#9f78e1";
    bar-empty = "─";
    bar-empty-font = "2";
    bar-empty-foreground = "${colors.foreground-alt}";
  };

  module.blacklight-acpi = {
    "inherit" = "module/xbacklight";
    type = "internal/backlight";
    card = "intel_backlight";
  };

  module.cpu = {
    type = "internal/cpu";
    interval = "1";
    format-prefix-font = "3";
    format-prefix = "%{A1:notify-send CPU \"$$(ps axch -o cmd\\:25,%cpu --sort=-%cpu | head)\":}  %{A}";
    format-prefix-foreground = "${colors.foreground}";
    format-underline = "#f90000";
    label = "%percentage%%";
  };

  module.memory = {
    type = "internal/memory";
    interval = "1";
    format-prefix = ''%{A1:notify-send MEMORY "$(ps axch -o cmd\\:25,rss --sort=-rss | head)":}  %{A}'';
    label-active-font = "1";
    format-prefix-foreground = "${colors.foreground}";
    format-underline = "#4bffdc";
    label = "%percentage_used%%";
  };

  module.wlan = {
    type = "internal/network";
    interface = "wlan0";
    interval = "2.0";

    format-connected = "<label-connected>";
    format-connected-underline = "#9f78e1";
    label-connected = "%essid% | %downspeed%";

    format-disconnected = "";

    ramp-signal-0 = "";
    ramp-signal-1 = "";
    ramp-signal-2 = "";
    ramp-signal-3 = "";
    ramp-signal-4 = "";
    ramp-signal-foreground = "${colors.foreground-alt}";
  };

  module.time = {
    type = "internal/date";
    interval = "1";
    #label-font = "3";
    format-margin = "0";

    time = ''%I:%M'';
    date = ''%d %b'';
    time-alt = ''%I:%M:%S'';
    date-alt = ''%a %d/%m/%y'';

    label = " %date%   %time%";
    label-background = "${colors.background}";
    label-padding = "0";
  };

  module.pulseaudio = {
    type = "internal/pulseaudio";

    format-volume-margin = "1";
    format-volume = "<ramp-volume> <label-volume>";
    label-volume = "%percentage%%";
    format-volume-background = "${colors.background}";
    format-volume-padding = "0";
    use-ui-max = "false";
    interval = "5";
    "#format-volume-font" = "6";

    ramp-volume-0 = "";
    ramp-volume-1 = "";
    ramp-volume-2 = "";


    label-muted = "";
    label-muted-background = "${colors.background}";
    label-muted-padding = "1";
  };

  module.alsa = {
    type = "internal/alsa";

    format-volume = "<label-volume> <bar-volume>";
    label-volume = "VOL";
    label-volume-foreground = "${root.foreground}";

    format-muted-prefix = " ";
    format-muted-foreground = "${colors.foreground-alt}";
    label-muted = "sound muted";

    bar-volume-width = "10";
    bar-volume-foreground-0 = "#55aa55";
    bar-volume-foreground-1 = "#55aa55";
    bar-volume-foreground-2 = "#55aa55";
    bar-volume-foreground-3 = "#55aa55";
    bar-volume-foreground-4 = "#55aa55";
    bar-volume-foreground-5 = "#f5a70a";
    bar-volume-foreground-6 = "#ff5555";
    bar-volume-gradient = "false";
    bar-volume-indicator = "|";
    bar-volume-indicator-font = "2";
    bar-volume-fill = "─";
    bar-volume-fill-font = "2";
    bar-volume-empty = "─";
    bar-volume-empty-font = "2";
    bar-volume-empty-foreground = "${colors.foreground-alt}";
  };

  module.battery = {
    type = "internal/battery";
    battery = "BAT0";
    adapter = "AC";
    full-at = "99";

    #label-charging-font = "3";
    #label-discharging-font = "3";
    ramp-capacity-font = "3";
    label-charging = " %percentage%%";
    label-discharging = "%percentage%%";
    format-charging = "<label-charging>";
    format-charging-underline = "#ffb52a";

    format-discharging = "<ramp-capacity> <label-discharging>";
    format-discharging-underline = "${self.format-charging-underline}";

    format-full-font = "3";
    format-full-prefix = " ";
    format-full-prefix-foreground = "${colors.foreground}";
    format-full-underline = "${self.format-charging-underline}";


    ramp-capacity-0 = "";
    ramp-capacity-1 = "";
    ramp-capacity-2 = "";
    ramp-capacity-3 = "";
    ramp-capacity-4 = "";
    ramp-capacity-foreground = "${colors.foreground}";
    animation-charging-0 = "";
    animation-charging-1 = "";
    animation-charging-2 = "";
    animation-charging-foreground = "${colors.foreground-alt}";
    animation-charging-framerate = "750";

    animation-discharging-0 = "";
    animation-discharging-1 = "";
    animation-discharging-2 = "";
    animation-discharging-foreground = "${colors.foreground-alt}";
    animation-discharging-framerate = "750";
  };

  module.temperature = {
    type = "internal/temperature";
    thermal-zone = "0";
    warn-temperature = "60";

    format = "<label>";
    format-underline = "#f50a4d";
    format-warn = "<ramp> <label-warn>";
    format-warn-underline = "${self.format-underline}";

    label = "%temperature-c%";
    label-warn = "%temperature-c%";
    label-warn-foreground = "${colors.secondary}";

    ramp-0 = "";
    ramp-1 = "";
    ramp-2 = "";
    ramp-foreground = "${colors.foreground-alt}";
  };

  module.powermenu = {
    type = "custom/menu";

    expand-right = "true";

    format-spacing = "1";

    label-open = "";
    label-open-foreground = "${colors.secondary}";
    label-close = " cancel";
    label-close-foreground = "${colors.secondary}";
    label-separator = "|";
    label-separator-foreground = "${colors.foreground-alt}";

    menu-0-0 = "reboot";
    menu-0-0-exec = "menu-open-1";
    menu-0-1 = "power off";
    menu-0-1-exec = "menu-open-2";

    menu-1-0 = "cancel";
    menu-1-0-exec = "menu-open-0";
    menu-1-1 = "reboot";
    menu-1-1-exec = "sudo reboot";

    menu-2-0 = "power off";
    menu-2-0-exec = "sudo poweroff";
    menu-2-1 = "cancel";
    menu-2-1-exec = "menu-open-0";
  };

  module.nautilus = {
    type = "custom/text";
    content = "";
    click-left = "nautilus";
  };

  module.firefox = {
    type = "custom/text";
    content = "🦊";
    click-left = "firefox";
  };

  module.os = {
    type = "custom/text";
    content = "%{T5}%{T}";
  };

  settings = {
    screenchange-reload = "true";
    pseudo-transparency = "false";
  };

  global.wm = {
    margin-top = "5";
    margin-bottom = "5";
  };
}
