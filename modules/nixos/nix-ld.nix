{ pkgs, ... }:
{
  # Run prebuilt, non-Nix binaries. These add to the nixpkgs module's default
  # libraries, which already cover zlib, openssl, curl, libstdc++ and similar.
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # Core
      dbus
      e2fsprogs
      expat
      glib
      icu
      krb5
      libcap
      libsecret
      libusb1
      libuuid
      ncurses
      nspr
      nss
      fuse
      fuse3

      # Graphics
      libdrm
      libgbm
      libGL
      libglvnd
      mesa
      vulkan-loader

      # Windowing
      libxkbcommon
      wayland
      libx11
      libxcb
      libxcomposite
      libxcursor
      libxdamage
      libxext
      libxfixes
      libxi
      libxrandr
      libxrender
      libxscrnsaver
      libxtst

      # GUI toolkits
      at-spi2-atk
      at-spi2-core
      atk
      cairo
      cups
      fontconfig
      freetype
      gdk-pixbuf
      gtk3
      gtk4
      libnotify
      pango

      # Audio and media
      alsa-lib
      libpulseaudio
      pipewire
      SDL2
    ];
  };
}
