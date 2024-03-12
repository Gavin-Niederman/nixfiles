{ pkgs, ... }:

{
  config = {
    environment.systemPackages = with pkgs; [
      advantagescope
      choreo
      pathplanner

      wpilib.glass
      wpilib.smartdashboard
      wpilib.shuffleboard
    ];
  };
}