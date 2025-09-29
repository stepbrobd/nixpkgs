{
  buildDunePackage,
  fetchFromGitHub,
  findlib,
  ppxlib,
  stdcompat,
}:

buildDunePackage (finalAttrs: {
  pname = "metapp";
  version = "0.4.4";

  patchPhase = ''
    substituteInPlace metapp/metapp.ml \
      --replace-fail \
        '| Pexp_fun (_label, _default, pat, body) when not (check_pat pat) ->' \
        '| Pexp_fun (arg_label, pat, body) when not (check_pat pat) ->'
  '';

  src = fetchFromGitHub {
    owner = "ocamllibs";
    repo = "metapp";
    tag = "v${finalAttrs.version}";
    hash = "sha256-lRE6Zh1oDnPOI8GqWO4g6qiS2j43NOHmckgmJ8uoHfE=";
  };

  buildInputs = [
    findlib
    ppxlib
    stdcompat
  ];
})
