with import <nixpkgs> {};
let

  python = pkgs.python35Full;

  pythonPackages = pkgs.python35Packages;

in {
  blogEnv = stdenv.mkDerivation {
    name = "blog";
    buildInputs = with pythonPackages; [ Nikola python jupyter ws4py watchdog webassets ghp-import  ];
  };
}
