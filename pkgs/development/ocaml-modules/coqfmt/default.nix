{ lib
, fetchFromGitHub
, buildDunePackage
, coq_8_18
, coqPackages_8_18
, alcotest
, dune-build-info
}:

buildDunePackage {
  pname = "coqfmt";
  version = "unstable-2024-02-12";

  src = fetchFromGitHub {
    owner = "toku-sa-n";
    repo = "coqfmt";
    rev = "005d3ffbdd0be7742dbabd7a8425425655377a6f";
    hash = "sha256-spSS7PMbCZ+my9jzbZPGxEYJrQ4c7yz5szpaAb+qXlY=";
  };

  minimalOCamlVersion = "4.14";
  duneVersion = "3";

  buildInputs = [
    coq_8_18
    coqPackages_8_18.serapi
  ];

  propagatedBuildInputs = [
    alcotest
    dune-build-info
  ];

  dontDetectOcamlConflicts = true;

  meta = {
    homepage = "https://github.com/toku-sa-n/coqfmt";
    description = "Coq code formatter";
    license = with lib.licenses; [ agpl3Plus mit ];
    maintainers = with lib.maintainers; [ stepbrobd ];
    mainProgram = "coqfmt";
  };
}
