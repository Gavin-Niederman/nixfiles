{
  imports = [
    ./apps # programs that need system-level setup
    ./desktop # compositor, greeter and GNOME services
    ./nix # tooling for Nix itself
    ./services # background daemons
    ./system # boot, hardware, users
  ];
}
