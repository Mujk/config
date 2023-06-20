# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:
let
  NAME = "Florian Mujkanovic"; # change for GH
  EMAIL = "Mujk@proton.me"; #     "
in
{
  imports =
    [ 
      ./hardware-configuration.nix # Include the results of the hardware scan
      <home-manager/nixos> # Include home manager
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-90872624-6674-434e-af99-9769acd3939e".device = "/dev/disk/by-uuid/90872624-6674-434e-af99-9769acd3939e";
  boot.initrd.luks.devices."luks-90872624-6674-434e-af99-9769acd3939e".keyFile = "/crypto_keyfile.bin";

  networking.hostName = "flx"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable tlp for battery
  services.tlp.enable = true;

  # Enable the Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  programs.hyprland.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "de";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Enable virtualbox
  virtualisation.virtualbox.host.enable = true;

  # Enable Docker
  virtualisation.docker.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.flx = {
    isNormalUser = true;
    description = "flx"; # change for GH upload
    extraGroups = [ "networkmanager" "wheel" "vboxusers" "docker" ];
    packages = with pkgs; [
      ## browser
      librewolf
      firefox
      ungoogled-chromium
      ## email
      thunderbird
      ## text editor
      neovim # to home manager
      emacs # to home manager
      android-studio
      vscode-fhs
      ## tui
      alacritty # to home manager
      fish # to home manager
      bottom # htop rep (command: btm)
      starship # shell prompt / to home manager
      ripgrep # grep rep
      exa # ls rep / to home manager
      fd # find rep
      nerdfonts
      zellij # tmux rep
      zoxide # cd rep
      cmake
      ## gui
      keepassxc
      anki
      signal-desktop
      libreoffice
      ## wayland
      waybar # to home manager
      wofi # to home manager
      ## languages
      ### rust
      gcc
      clang

      rustc
      cargo
      rustup
      rust-analyzer
      trunk
      #### dioxus
      dioxus-cli
      #### tauri
      cargo-tauri
      tauri-mobile

      python3Full
      jdk
      java-language-server
      kotlin
      kotlin-language-server
      lua
      lua-language-server
      nil # Nix language server
      elixir
      elixir-ls
      zig
      zls
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  home-manager.users.flx = {
    home.stateVersion = "23.11";
      home.packages = with pkgs; [
        wpaperd # wallpaper daemon
        git
        bat # cat rep
      ];
      programs.git = {
        enable = true;
        userName = "${NAME}";
        userEmail = "${EMAIL}";
      };
      #xdg.configFile."wpaperd/wallpaper.toml".source = ./wpaperd.conf;

      home.file = {
        ".config/wpaperd/wallpaper.toml" = {
      text = ''
      [default]
      path = "/home/flx/DATA/pictures/wallpaper/lonely-wolf.pdf"
      '';
      };
      ".config/bat/config" = {
        text = ''
        --theme="Catppuccin-mocha"
        '';
      };
    };
      # themes
      xdg.configFile."bat/themes/Catppuccin-mocha.tmTheme".source = /etc/nixos/themes/bat-catppuccin-mocha.tmTheme;
  };
}
