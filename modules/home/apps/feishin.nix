{ pkgs, ... }:
{
  # Feishin keeps its settings in localStorage, so these were loaded by hand.
  # If it ever supports a config file, set these through it:
  # - general.theme = "catppuccinMocha"
  # - visualizer.audiomotionanalyzer: barSpace 0.2, gravity 20, maxDecibels -25,
  #   mode 6, peakLine false, reflexAlpha 0.35, showPeaks true, smoothing 0.3,
  #   splitGradient true, and "Custom Gradient 1" (horizontal) for gradient,
  #   gradientLeft and gradientRight, with stops #f5c2e7 #cba6f7 #eba0ac #fab387
  #   #a6e3a1 #89dceb #89b4fa #b4befe
  # - visualizer.butterchurn: blendTime 0, cyclePresets false,
  #   currentPreset "Unchained - Rewop"
  home.packages = [ pkgs.feishin ];
}
