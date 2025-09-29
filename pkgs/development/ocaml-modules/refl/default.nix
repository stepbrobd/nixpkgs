{
  buildDunePackage,
  fetchFromGitHub,
  fix,
  stdcompat,
  # traverse,
}:

buildDunePackage (finalAttrs: {
  pname = "refl";
  version = "0.4.1";

  src = fetchFromGitHub {
    owner = "ocamllibs";
    repo = "refl";
    tag = "v${finalAttrs.version}";
    hash = "sha256-aRyx58CPxcTkQa+s+ZL61Xfwcdn8g2GW+uOcCQR7mxY=";
  };

  buildInputs = [
    fix
    stdcompat
    # traverse
  ];
})
