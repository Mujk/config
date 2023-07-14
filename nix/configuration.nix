{ config, lib, pkgs, ... }:
{
  imports =
    [ 
      ./hardware-configuration.nix # Include the results of the hardware scan
      <home-manager/nixos> # Include home manager
    ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

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
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

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

  # Change /bin/sh to dash
  environment.binsh = "${pkgs.dash}/bin/dash";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable tlp AND auto-cpufreq for battery // maybe delete 1
  services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 20;
      };
  };
  services.thermald = { enable = true; };

  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };


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

    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    efibootmgr
    i7z # i7 reporting tool. i7z tui / i7z-gui gui
    gcc
    clang
    rustc
    rustfmt
    rust-analyzer
    trunk
    dioxus-cli
    cargo-tauri
    tauri-mobile
    python3Full
    chicken
    ghc
    #kotlin
    #kotlin-language-server
    nil # Nix language server
    elixir
    elixir-ls
    #ccls
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

  # Enable emacs daemon
  # services.emacs = true; # FIXME check out Nix emacs docs

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
  home-manager.users.flx =
    let
      NAME = "Florian Mujkanovic";
      EMAIL = "Mujk@proton.me";
    in
    {
    home.stateVersion = "23.11";
    home.packages = with pkgs; [
      emacs # replace with nix-doom-emacs
      #android-studio
      godot_4
      alacritty # add config in hm
      fish # replace with nushell
      # manix # nix doc searcher
      waybar # replaye with eww
      eww-wayland
      wofi # add config / replace with kickoff?
      #kickoff # app launcher
      git
      bat # cat rep
      bottom # htop rep (command: btm)
      ripgrep # grep rep
      exa # ls rep # remove after switching to nushell
      fd # find rep
      neofetch
      nerdfonts
      unicode-paracode
      zoxide # cd rep
      atuin # better shell history
      mpv # media player
      youtube-dl # play yt with mpv
      wpaperd # wallpaper daemon
      librewolf
      firefox
      ungoogled-chromium
      keepassxc
      anki
      gimp
      libreoffice
      signal-desktop
      spotify
      thunderbird # replace with emacs
    ];
    programs = {
      nushell = {
        enable = false; # FIXME not complete
        shellAliases = {
          lsa = "exa --icons -a -F --group-directories-first";
          lst = "exa --icons -T --group-directories-first";
          cat = "bat";
          power = "cat /sys/class/power_supply/BAT0/capacity";
          volume = "amixer get Master";
          volumeset = "amixer set Master";
          shut = "shutdown now";
          reboot = "sudo reboot now";
          resPer = "sudo chmod -R a+rwX";
          cl = "clear";
          cheat = "emacsclient ~/DATA/documents/cheatsheet/README.org";
          nv = "nvim";
          nixco = "sudo emacsclient /etc/nixos/configuration.nix";
          nixre = "sudo nixos-rebuild switch";
          nixup = "sudo nixos-rebuild switch --upgrade";
          nixcl = "nix-collect-garbage -d";
          backup = "sudo bash ~/DATA/scripts/backup-tool.sh";
          ec = "emacsclient";
          cd = "z";
          nmcom = "nmcli device wifi connect";
          nmdb = "nmcli device wifi connect WIFI@DB";
          nmice = "nmcli device wifi connect WIFIonICE";
        };
        configFile = { text = ''
                         # custom functions
                         def mkcd [dir] {
                           mkdir dir
                           cd dir
                         }

                         use ~/.cache/starship/init.nu
                         source ~/.zoxide.nu
                         source ~/.local/share/atuin/init.nu
                       '';
                      };
        envFile = { text = ''
                      mkdir ~/.cache/starship
                      starship init nu | save -f ~/.cache/starship/init.nu
                      zoxide init nushell | save -f ~/.zoxide.nu
                      mkdir ~/.local/share/atuin/
                      atuin init nu | save ~/.local/share/atuin/init.nu
                    '';
                  };
      };
      git = {
        enable = true;
        userName = "${NAME}";
        userEmail = "${EMAIL}";
      };
      #FIXME enable alacritty with this
      #alacritty = {
      #  enable = true;
      #  settings = {
      #    import = [ /etc/nixos/themes/alacritty-catppuccin-mocha.yml ];
      #      shell.program = "fish";
      #      window.opacity = 0.7;
      #  };
      #};
      starship =
        let
          flavour = "mocha";
        in
        {
        enable = true;
        settings = {
          palette = "catppuccin_${flavour}";
          character = {
            success_symbol = "[ᐅ ](bold green)";
            error_symbol = "[ᐅ ](bold red)";
          };
          battery = {
            charging_symbol = " ⚡️ ";
            discharging_symbol = " ";
            unknown_symbol = " ? ";
            # FIXME
              #display = {
              #  threshold = 100;
              #  style = "bold green";
              #  discharging_symbol = " ";
              #};
              # FIXME only 1 display work
              #display = {
              #  threshold = 35;
              #  style = "bold yellow";
              #};
              #display = {
              #  threshold = 15
              #  style = "bold red";
              #};
            };
          }; #// builtins.fromTOML (builtins.readFile
           # (pkgs.fetchFromGitHub
          #{
          #  owner = "catppuccin";
          #  repo = "starship";
          #  rev = ""; # FIXME? Replace with the latest commit hash
          #  sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
          #} + /palettes/${flavour}.toml));
        };
      };
      #FIXME Replace with alacritty config above
      home.file = {
        ".config/alacritty/alacritty.yml" = {
         text = ''
         import:
           - ~/etc/nixos/themes/alacritty-catppuccin-mocha.yml
         shell:
           program: fish
         window:
           opacity: 0.7  # set transparency
         '';
        };
      };
      # hyprland
      home.file = {
        ".config/hypr/hyprland.conf" = {
         text = ''
         monitor=DP-1, 1920x1080, 0x0, 1
         #monitor=,preferred,auto,auto
         exec-once = waybar & wpaperd
         env = XCURSOR_SIZE,24
         input {
          kb_layout = de
          follow_mouse = 1
          touchpad {
            natural_scroll = no
          }
            sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
         }
         general {
           gaps_in = 2
           gaps_out = 1
           border_size = 1
           col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
           col.inactive_border = rgba(595959aa)
           layout = master
         }
         decoration {
           rounding = 8
           blur = yes
           blur_size = 3
           blur_passes = 1
           blur_new_optimizations = on
           drop_shadow = yes
           shadow_range = 4
           shadow_render_power = 3
           col.shadow = rgba(1a1a1aee)
         }
         animations {
           enabled = no
         }
         master {
           new_is_master = no
         }
         gestures {
           workspace_swipe = off
         }
         device:epic-mouse-v1 {
           sensitivity = -0.5
         }
         $mainMod = SUPER
         bind = $mainMod, Q, exec, alacritty
         bind = $mainMod, C, killactive,
         bind = $mainMod, M, exit,
         bind = $mainMod, E, exec, dolphin
         bind = $mainMod, V, togglefloating,
         bind = $mainMod, R, exec, wofi --show drun
         bind = $mainMod, P, pseudo, # dwindle
         bind = $mainMod, J, togglesplit, # dwindle
         # Move focus with mainMod + arrow keys
         bind = $mainMod, left, movefocus, l
         bind = $mainMod, right, movefocus, r
         bind = $mainMod, up, movefocus, u
         bind = $mainMod, down, movefocus, d
         # Switch workspaces with mainMod + [0-9]
         bind = $mainMod, 1, workspace, 1
         bind = $mainMod, 2, workspace, 2
         bind = $mainMod, 3, workspace, 3
         bind = $mainMod, 4, workspace, 4
         bind = $mainMod, 5, workspace, 5
         bind = $mainMod, 6, workspace, 6
         bind = $mainMod, 7, workspace, 7
         bind = $mainMod, 8, workspace, 8
         bind = $mainMod, 9, workspace, 9
         bind = $mainMod, 0, workspace, 10
         # Move active window to a workspace with mainMod + SHIFT + [0-9]
         bind = $mainMod SHIFT, 1, movetoworkspace, 1
         bind = $mainMod SHIFT, 2, movetoworkspace, 2
         bind = $mainMod SHIFT, 3, movetoworkspace, 3
         bind = $mainMod SHIFT, 4, movetoworkspace, 4
         bind = $mainMod SHIFT, 5, movetoworkspace, 5
         bind = $mainMod SHIFT, 6, movetoworkspace, 6
         bind = $mainMod SHIFT, 7, movetoworkspace, 7
         bind = $mainMod SHIFT, 8, movetoworkspace, 8
         bind = $mainMod SHIFT, 9, movetoworkspace, 9
         bind = $mainMod SHIFT, 0, movetoworkspace, 10
         # Scroll through existing workspaces with mainMod + scroll
         bind = $mainMod, mouse_down, workspace, e+1
         bind = $mainMod, mouse_up, workspace, e-1
         # Move/resize windows with mainMod + LMB/RMB and dragging
         bindm = $mainMod, mouse:272, movewindow
         bindm = $mainMod, mouse:273, resizewindow
         '';
        };
      # wpaperd
        ".config/wpaperd/wallpaper.toml" = {
      text = ''
      [default]
      path = "/home/flx/DATA/pictures/wallpaper/lonely-wolf.jpg"
      '';
      };
      # bat
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
