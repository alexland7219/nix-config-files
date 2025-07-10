# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

let
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz";
    sha256 = "sha256:1m7slrrgfv9lj6psnk9wd7q6s7dsnghk24sqlvajshian8sn8ncj";
  };
in
{
  imports =
    [
      ./hardware-configuration.nix
      "${home-manager}/nixos"
    ];
  
  nixpkgs.overlays = [
    (import ./overlays/libpkcs11-dnie.nix)
    (import ./overlays/uiua-overlay.nix)
  ];  

  # Enable experimental features and Unfree Packages
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "HOSTNAME";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Amsterdam";

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "intl";
    options = "lv5:rwin_switch_lock";
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Locale and formatting

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "de_DE.UTF-8/UTF-8"
    ];
  };

  environment.variables = {
    LANG           = "en_US.UTF-8";
    LC_NUMERIC     = "en_US.UTF-8";
    LC_TIME        = "de_DE.UTF-8";
    LC_PAPER       = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY    = "de_DE.UTF-8";
    LC_ALL         = "";
  };

  # Programs, fonts and home manager

  home-manager.users.alex = import ./home.nix;
  home-manager.backupFileExtension = "bak";

  users.users.alex = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager"];
    packages = with pkgs; [
      tree
      git
      mullvad-vpn
      qbittorrent
      dolphin-emu
      vscodium
      magic-wormhole
      vlc
      keepassxc
      texmaker
      anki-bin
      yt-dlp
      spotdl
      android-studio
      android-tools
      mpv
      exercism
      tauon
      flutter
      telegram-desktop
      kdePackages.okular
      kdePackages.poppler
      swi-prolog
      virt-viewer
      discord
      element-desktop
      libreoffice-fresh
      wkhtmltopdf
      cbqn
      uiua
    ];
  };

  programs.firefox = {
    enable = true;
    policies = {
      SecurityDevices = {
	Add = {
	   "PKCS#11 DNIe" = "${pkgs.libpkcs11-dnie}/lib/libpkcs11-dnie.so";
	};
      };
    };
  };
 
  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    vim 
    wget
    alacritty
    htop
    libgcc
    gcc
    lua
    zulu23
    killall
    gnomeExtensions.blur-my-shell
    syncthing
    libxkbcommon
    libpkcs11-dnie
    
    # Retroarch cores
    (retroarch.withCores (cores: with cores; [
	snes9x
     ]))

    # Python 3.11 packages
    (python311.withPackages (ps: with ps; [
	pip
	numpy
	requests
	matplotlib
	requests-toolbelt
	pyyaml
	rich
	pydantic
	pandas
	python-telegram-bot
	discordpy
	python-dotenv
    ]))

    # Haskell packages
    haskellPackages.ghc
    haskellPackages.cabal-install
    haskellPackages.hlint
  ];

  fonts.packages = with pkgs; [
    jetbrains-mono    
    ubuntu-sans-mono
    uiua386
    bqn386
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Services

  # services.openssh.enable = true;
  services.mullvad-vpn.enable = true;
  services.pcscd.enable = true;

  services.syncthing = {
    enable = true;
    user = "alex";
    dataDir = "/home/alex";
    configDir = "/home/alex/.config/syncthing";
  };

  system.stateVersion = "25.05"; 
}

