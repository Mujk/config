# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "fnix"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable network manager applet
  programs.nm-applet.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.utf8";
    LC_IDENTIFICATION = "de_DE.utf8";
    LC_MEASUREMENT = "de_DE.utf8";
    LC_MONETARY = "de_DE.utf8";
    LC_NAME = "de_DE.utf8";
    LC_NUMERIC = "de_DE.utf8";
    LC_PAPER = "de_DE.utf8";
    LC_TELEPHONE = "de_DE.utf8";
    LC_TIME = "de_DE.utf8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable wayland
  xdg.portal.wlr.enable = true;
  
  # Enable Desktop Environment.
  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd leftwm";
  #       user = "f";
  #     };
  #   };
  # };
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.windowManager.leftwm.enable = true;
  services.xserver.windowManager.qtile.enable = true;
  
  # Configure keymap in X11
  services.xserver = {
    layout = "de";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  #opengl mainly for steam
  hardware.opengl.driSupport32Bit = true;
  
  # Enabke bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true; # bluetooth gui, maybe find terminal alt
  
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
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.f = {
    isNormalUser = true;
    description = "F";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.elvish;
    packages = with pkgs; [
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # enable flatpak support
  # services.flatpak.enable = true;
  
  # fonts
  fonts.fonts = with pkgs; [
      nerdfonts
    ];  
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  wget
  git
  zip
  unzip
  greetd.greetd # minimalistic display manager
  greetd.tuigreet # greetd / tuigreed maybe unneeded here
  greetd.wlgreet # like greetd maybe unneeded here
    
  #terminal
  alacritty # terminal emulator
  helix # texteditor
  starship # terminal prompt
  bat # cat replacemant
  neofetch # for the flex
  exa # ls replacement, same as lsd  
  elvish # powerfull shell
  asciiquarium 
  ripgrep # grep replacement
  fd # find replacement
  procs # ps replacement     
  #alt shells
  ion
  fish
  nushell
  cmake
  #alt editor
  neovim         
    
  # tui testing
  lf
    
  # leftwn dependencies
  feh # image viewer
  compton # X11 compositor
  picom # X11 compositor   # delete one
  polybar # status bar
  conky # X11 system monitor  # unneeded, can be deleted
  dmenu # app launcher
  rofi # app launcher and window switcher
    
  # gui
  gimp # image editor
  firefox # web browser
  librewolf # web browser, firefox fork
  thunderbird # email client
  keepassxc # password manager
  signal-desktop # messanger app
  # session-desktop # messanger app
  ungoogled-chromium # chromium web browser
  spotify
  discord
  vscode.fhs
    
  # gaming
  steam
  superTux
  superTuxKart
   
  # languages
  rustup
  #rustc
  #cargo # package manager
  rust-analyzer # lsp
  #advanced
  eww # widgets
    
  python3Full
  python-language-server # lsp

  gcc
  
  go
  gopls # lsp
        
  elixir
  elixir_ls # lsp
    
  erlang
  erlang-ls # lsp
    
  rnix-lsp # lsp
  
  texlive.combined.scheme-basic  
  texlab
    
  dart
  flutter # framework
  
  kotlin
  kotlin-language-server # lsp
    
  #nim
  #nimlsp # lsp
  
  #taplo # TOML lsp
      
  #nodejs
  #nodePackages_latest.typescript
  #nodePackages_latest.typescript-language-server
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

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
  system.stateVersion = "22.05"; # Did you read the comment?

}
