{ zlib, icu, fontconfig, openssl, libX11, libICE, libSM, copyDesktopItems
, buildDotnetModule, dotnetCorePackages, fetchFromGitHub, makeDesktopItem, ... }:
buildDotnetModule {
  pname = "fvim";
  version = "0.3.549";
  src = fetchFromGitHub {
    owner = "yatli";
    repo = "fvim";
    rev = "ee4316c";
    sha256 = "sha256-LJWWKsYT0TXwNwfyI3UkF0f/Ugj4Xt3/sncasUYwhx0=";
  };

  patches = [ ./fvim-manifest-tweaks.patch ];

  runtimeDeps = [ zlib icu fontconfig openssl libX11 libICE libSM ];
  nativeBuildInputs = [ copyDesktopItems ];

  postFixup = ''
    install -Dm 555 $src/Assets/fvim.png $out/share/icons/pixmaps/fvim.png
  '';

  nugetDeps = ./fvim-deps.nix;
  projectFile = "fvim.fsproj";

  selfContainedBuild = true;

  dotnet-sdk = dotnetCorePackages.sdk_6_0;
  dotnet-runtime = dotnetCorePackages.runtime_6_0;

  desktopItems = [
    (makeDesktopItem {
      name = "FVim";
      desktopName = "fvim";
      exec = "FVim";
      icon = "fvim";
      type = "Application";
    })
  ];
}
