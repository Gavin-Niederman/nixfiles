{ pkgs, fetchFromGitHub, }:

pkgs.vimUtils.buildVimPlugin {
  pname = "direnv.vim";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "direnv";
    repo = "direnv.vim";
    rev = "ab2a7e0";
    sha256 = "sha256-Lwwm95UEkS8Q0Qsoh10o3sFn48wf7v7eCX/FJJV1HMI=";
  };
}
