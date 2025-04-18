build-conf:
{ config, pkgs, ... }:
let
    conf = build-conf;
in
{
  nix = {
    package = pkgs.nixVersions.stable;
    optimise.automatic = true;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings = {
        substituters = [
          "https://nix-community.cachix.org"
          "https://lean4.cachix.org"
        ];
        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "lean4.cachix.org-1:mawtxSxcaiWE24xCXXgh3qnvlTkyU7evRRnGeAhD4Wk="
        ];
    };
  };

  system.autoUpgrade.channel = "https://nixos.org/channels/nixos-unstable";

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot = {
    loader.systemd-boot.enable = true;
    tmp.useTmpfs = true;
    initrd.availableKernelModules = ["usbhid" "uas" "usb_storage" "nvme"];
    #kernelParams = [
    #];
    loader.efi.canTouchEfiVariables = true;
    loader.efi.efiSysMountPoint = "/boot/efi";
    enableContainers = true;
  };

  networking.hostName = "nix"; # Define your hostname.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # x11 stuff
  services.xserver = {
    enable = true;

    xkb.layout = "us";
    xkb.variant = "";

    videoDrivers = ["nvidia"];

    desktopManager = {
      xterm.enable = false;
    };

    windowManager = {
      i3.enable = conf.wm == "i3";
    };
  };

  services.desktopManager = {
    plasma6.enable = conf.wm == "plasma";
  };

  services.displayManager = {
    sddm.enable = conf.wm == "plasma" || conf.wm == "xmonad";
    defaultSession = if conf.wm == "i3" then "xfce+i3" else null;
  };

  # services.xwayland = {
  #   enable = conf.is-wayland;
  # };

  services.fstrim.enable = true;

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
    };

    bluetooth.enable = true;
    bluetooth.settings.General.Experimental = true;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
    extraConfig.pipewire."92-low-latency" = {
      context.properties = {
        default.clock.rate = 48000;
        default.clock.quantum = 32;
        default.clock.min-quantum = 32;
        default.clock.max-quantum = 32;
      };
    };

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  xdg.mime.defaultApplications = {
    "text/html" = "org.mozilla.firefox.desktop";
    "x-scheme-handler/http" = "org.mozilla.firefox.desktop";
    "x-scheme-handler/https" = "org.mozilla.firefox.desktop";
    "x-scheme-handler/about" = "org.mozilla.firefox.desktop";
    "x-scheme-handler/unknown" = "org.mozilla.firefox.desktop";
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  users.mutableUsers = false;
  users.users.mbk = {
    isNormalUser = true;
    description = "mehbark";
    extraGroups = [ "networkmanager" "wheel" "tty" ];
    hashedPassword = "$6$AgDjrnyBPBpfMpB1$NxjyeU/WxsOXrY7KpnJethtGz28LO.hNARG5J8adIoxDFkBVG/H9wJEiG0A09E7JgguoPxFWmwYIBQLTbknVv1";
  };

  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 2048;
      cores = 3;
      graphics = true;
    };
    users.users.root = {
      isSystemUser = true;
      initialPassword = "";
    };
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
  };

  networking.firewall.allowedTCPPorts = [ 22 8384 22000 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];

  # services.emacs.enable = true;
  # services.emacs.package = import /home/mbk/.emacs.d { pkgs = pkgs; };
  # services.emacs.defaultEditor = true;

  # Allow unfree packages (sorry)
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-22.3.27"
  ];
  nixpkgs.overlays = [
    (final: prev: {
      blender = prev.blender.override { cudaSupport = true; };
    })
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     neovim
     wget
     unzip
     git
     curl
     # just too nice
     # just too many slightly outdated things
     # busybox
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  environment.variables.EDITOR = "nvim";
  environment.variables.SHELL  = "fish";
  environment.variables.TERM   = "kitty";
  # BAD IDEA! I DON'T HAVE A CONCRETE REASON, MAINLY JUST VIBES
  # STILL MILES BETTER THAN NIX_AUTO_INSTALL THOUGH
  environment.variables.NIX_AUTO_RUN = "1";

  services.xserver.windowManager.xmonad = if conf.wm == "xmonad"
  then {
    enable = true;
    enableContribAndExtras = true;
  } else {};

  services.xserver.displayManager.sessionCommands = if conf.wm == "xmonad"
  then ''
    xset -dpms
    xset s blank
    xset s 300
    ${pkgs.lightlocker}/bin/lightlocker --idle-hint &
  '' else "";

  systemd.targets.hybrid-sleep.enable = conf.wm == "xmonad";
  services.logind.extraConfig = if conf.wm == "xmonad"
  then ''
    IdleAction=hybrid-sleep
    IdleActionSec=20s
  '' else "";

  services.syncthing = {
    enable = true;
    user = "mbk";
    dataDir = "/home/mbk/Sync";
    configDir = "/home/mbk/.config/syncthing";
    settings.devices = {
      pixel-6 = { id = "2QJMXQD-OTLK5TM-KNIZUMA-HM3ISPI-7AVY4CG-EOHHYEV-2W5HUNN-DHXLRAJ"; };
    };
    settings.folders = {
      Sync = {
        path = "/home/mbk/Sync";
        devices = [ "pixel-6" ];
      };
    };
  };

  services.udev.extraRules = ''
  KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
  '';

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
