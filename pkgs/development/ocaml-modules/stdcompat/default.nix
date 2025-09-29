{
  lib,
  buildDunePackage,
  fetchFromGitHub,
}:

buildDunePackage (finalAttrs: {
  pname = "stdcompat";
  version = "21.1";

  minimalOCamlVersion = "4.06";

  src = fetchFromGitHub {
    owner = "ocamllibs";
    repo = "stdcompat";
    tag = finalAttrs.version;
    hash = "sha256-ptqky7DMc8ggaFr1U8bikQ2eNp5uGcvXNqInHigzY5U=";
  };

  # Otherwise ./configure script will run and create files conflicting with dune.
  dontConfigure = true;

  meta = {
    homepage = "https://github.com/ocamllibs/stdcompat";
    license = lib.licenses.lgpl2;
    maintainers = [ lib.maintainers.vbgl ];
  };
})
