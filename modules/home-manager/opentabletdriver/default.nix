{
  pkgs,
  lib,
  osConfig ? { },
  ...
}:

# OpenTabletDriver user-level bits for the Huion Kamvas Pro 16 (2018).
#
# The stock tablet configuration parses the touch strip's reports as express
# key bits, so it cannot be bound to anything. KamvasProStrip/ is a tiny OTD
# plugin with a report parser that is the stock one plus "0xF0 reports are an
# absolute wheel"; the configuration override below points the tablet at it
# and declares the strip as a 7-position wheel. The plugin also ships a
# "Virtual Mouse Scroll Binding": the stock Mouse Scroll Binding only works
# in Absolute/Relative mode (Artist Mode's virtual tablet cannot scroll),
# this one scrolls through OTD's virtual mouse and works in any mode. Bind
# it under "Wheel 1 Bindings" in the GUI; Invert on the counter-clockwise one.
#
# Only active on hosts that enable OTD system-side (latia).
let
  enabled = lib.attrByPath [ "hardware" "opentabletdriver" "enable" ] false osConfig;
  otd = pkgs.opentabletdriver;

  # Must target the same .NET major as ${otd} (see its runtimeconfig.json).
  kamvasProStrip = pkgs.stdenv.mkDerivation {
    pname = "otd-kamvas-pro-strip";
    version = "0.1.0";
    src = ./KamvasProStrip;

    nativeBuildInputs = [ pkgs.dotnetCorePackages.sdk_8_0 ];

    env = {
      DOTNET_CLI_TELEMETRY_OPTOUT = "1";
      DOTNET_NOLOGO = "1";
      DOTNET_SKIP_FIRST_TIME_EXPERIENCE = "1";
    };

    buildPhase = ''
      runHook preBuild
      export HOME=$TMPDIR
      dotnet build -c Release \
        -p:OTD_LIB=${otd}/lib/OpenTabletDriver \
        -o out
      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall
      install -Dm644 out/KamvasProStrip.dll -t $out/lib
      runHook postInstall
    '';
  };

  # Copy of OTD's built-in "Huion Kamvas Pro 16" configuration with the
  # parser swapped and the strip declared. Same Name => overrides the
  # built-in one.
  identifier = model: {
    VendorID = 9580;
    ProductID = 109;
    InputReportLength = 12;
    ReportParser = "KamvasProStrip.KamvasProStripReportParser";
    DeviceStrings."201" = "HUION_${model}_\\d{6}$";
    InitializationStrings = [ 200 ];
  };
  tabletConfig = {
    Name = "Huion Kamvas Pro 16";
    Specifications = {
      Digitizer = {
        Width = 344.2;
        Height = 193.6;
        MaxX = 68840;
        MaxY = 38720;
      };
      Pen = {
        MaxPressure = 8191;
        ButtonCount = 2;
      };
      AuxiliaryButtons.ButtonCount = 6;
      # Strip reports position 1 (top) .. 7 (bottom); the parser maps that
      # to 0..6. Sliding down is "clockwise".
      Wheels = [
        {
          AbsoluteWheelMax = 6;
          ButtonCount = 0;
        }
      ];
    };
    DigitizerIdentifiers = [
      (identifier "M183")
      (identifier "M20m")
    ];
    Attributes.libinputoverride = "1";
  };
in
{
  config = lib.mkIf enabled {
    # force: both were first dropped in by hand while developing this;
    # let home-manager take them over instead of refusing to activate.
    xdg.configFile = {
      "OpenTabletDriver/Plugins/KamvasProStrip/KamvasProStrip.dll" = {
        source = "${kamvasProStrip}/lib/KamvasProStrip.dll";
        force = true;
      };
      "OpenTabletDriver/Configurations/Huion Kamvas Pro 16.json" = {
        text = builtins.toJSON tabletConfig;
        force = true;
      };
    };
  };
}
